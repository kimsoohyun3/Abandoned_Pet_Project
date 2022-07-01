package com.project.pet.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.pet.entity.AnnouncementVo;
import com.project.pet.entity.PageMakerVo;
import com.project.pet.entity.PagingProcessingVo;
import com.project.pet.service.AnnouncementService;

@Controller
public class AnnouncementController {
	@Autowired
	AnnouncementService announcementService;

	// 공지사항 목록 화면
	@RequestMapping("/announcement")
	public String announcement(Model model, PagingProcessingVo pagingProcessingVo) {
		// 해당 상단메뉴 css 주기 위해
		model.addAttribute("nav", "announcement");
		
		// 공지사함 목록 화면에 보내기
		model.addAttribute("voList", announcementService.pagingListInquiry(pagingProcessingVo));

		// 페이징 처리
		int total = announcementService.totalAnnouncement();
		PageMakerVo pageMakerVo = new PageMakerVo(pagingProcessingVo, total);
		model.addAttribute("pageMakerVo", pageMakerVo);
		
		return "announcement/announcement";
	}

	// 공지사항 등록 화면
	@RequestMapping("/registerAnnouncement")
	public String registerAccouncement(Model model) {
		// 해당 상단메뉴 css 주기 위해
		model.addAttribute("nav", "announcement");

		return "announcement/registerAnnouncement";
	}

	// 공지사항 등록
	@RequestMapping("/insertAnnouncement")
	public String insertAnnouncement(@ModelAttribute AnnouncementVo vo, HttpSession session, RedirectAttributes re) {
		// 서버에서 한번 더 관리자인지 판별
		if (session.getAttribute("auth") != null) {
			if (session.getAttribute("auth").equals("A")) {
				announcementService.insertAnnouncement(vo);

				return "redirect:/announcement";
			}
			re.addFlashAttribute("failMessage", "관리자만 해당 기능을 사용할수 있습니다.");

			return "redirect:/announcement";
		}
		re.addFlashAttribute("failMessage", "관리자만 해당 기능을 사용할수 있습니다.");

		return "redirect:/announcement";
	}

	// 상세 공지사항 화면
	@RequestMapping("/detailAnnouncement")
	public String detailAnnouncement(Model model, @RequestParam int announcementNo, @ModelAttribute PagingProcessingVo pagingProcessingVo) {
		// 해당 상단메뉴 css 주기 위해
		model.addAttribute("nav", "announcement");

		// 공지사항 상세 데이터 화면에 보내기
		model.addAttribute("vo", announcementService.detailAnnouncement(announcementNo));

		// 다시 상세 공지사항 -> 공지사항 목록 이동시 해당 페이지로 올수 있도록 pagingProcessingVo 보내기
		model.addAttribute("pagingProcessingVo", pagingProcessingVo);

		// 조회수 증가
		announcementService.hitsUpAnnouncement(announcementNo);

		return "announcement/detailAnnouncement";
	}

	// 공지사항 목록 화면에서 공지사항 삭제
	@PostMapping("/deleteAnnouncement")
	@ResponseBody
	public String deleteAnnouncement(@RequestBody List<String> announcementArray, HttpSession session) {
		// 서버에서 한번 더 관리자인지 판별
		if (session.getAttribute("auth") != null) {
			if (session.getAttribute("auth").equals("A")) {
				announcementService.deleteAnnouncement(announcementArray);

				return "success";
			} else {
				return "fail";
			}
		}
		return "fail";
	}

	// 상세 공지사항 화면에서 공지사항 삭제
	@PostMapping("/deleteOneAnnouncement")
	@ResponseBody
	public String deleteOneAnnouncement(@RequestParam int announcementNo, HttpSession session) {
		// 서버에서 한번 더 관리자인지 판별
		if (session.getAttribute("auth") != null) {
			if (session.getAttribute("auth").equals("A")) {
				announcementService.deleteOneAnnouncement(announcementNo);

				return "success";
			} else {
				return "fail";
			}
		}
		return "fail";
	}

	// 공지사항 수정
	@RequestMapping("/alterAnnouncement")
	public String alterAnnouncement(@ModelAttribute AnnouncementVo vo, @ModelAttribute PagingProcessingVo pagingProcessingVo, HttpSession session, RedirectAttributes re) {
		// 서버에서 한번 더 관리자인지 판별
		if (session.getAttribute("auth") != null) {
			if (session.getAttribute("auth").equals("A")) {
				announcementService.alterAnnouncement(vo);

				// 수정 후 기존 상세 공지사항으로 넘어올수 있도록 데이터 보내기
				re.addAttribute("announcementNo", vo.getAnnouncementNo());
				re.addAttribute("currentPageNum", pagingProcessingVo.getCurrentPageNum());
				re.addAttribute("amount", pagingProcessingVo.getAmount());
				
				return "redirect:/detailAnnouncement";
			}
			re.addFlashAttribute("failMessage", "관리자만 해당 기능을 사용할수 있습니다.");

			// 수정 후 기존 상세 공지사항으로 넘어올수 있도록 데이터 보내기
			re.addAttribute("announcementNo", vo.getAnnouncementNo());
			re.addAttribute("currentPageNum", pagingProcessingVo.getCurrentPageNum());
			re.addAttribute("amount", pagingProcessingVo.getAmount());
			
			return "redirect:/detailAnnouncement";
		}
		re.addFlashAttribute("failMessage", "관리자만 해당 기능을 사용할수 있습니다.");

		// 수정 후 기존 상세 공지사항으로 넘어올수 있도록 데이터 보내기
		re.addAttribute("announcementNo", vo.getAnnouncementNo());
		re.addAttribute("currentPageNum", pagingProcessingVo.getCurrentPageNum());
		re.addAttribute("amount", pagingProcessingVo.getAmount());
		
		return "redirect:/detailAnnouncement";
	}
}
