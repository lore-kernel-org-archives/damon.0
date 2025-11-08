Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB092D73B4;
	Sat,  8 Nov 2025 04:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762574864; cv=none; b=HnMxIYhOdN8UDgpaQuncIkjQswUlpiy5dNrw1FOtb4EJ9Y7IML05NEnoJMNjpbbafeenQkDAd8UOctttnrtdyCM2C9S2LkHyXmiHoiLReI2L6R/C8XGRDA5D/7IwiXQSeLyVpbK5Sl2UICl5QIuOmyy8z8unaN8E2q81GkVJK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762574864; c=relaxed/simple;
	bh=bVWG8OxlLnY/I8fRElck+WGWHUB5rw/YbxUK/Sy7zcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sl6L5vOtn3kPy3jfrifm6JeaSw6brYl++Yd5UyY7gkJd5qyO79txbpOLWactHplxYWHeeIVabpD5StU6SndBUGNecpRrNwkioj7CHz8IgnCPf+v2IiO3ySfQV/H1crkfjJu85ip9ngNEoumxpYdTUCTIB0rSv6CPRrBpgCS5VoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVEGeBBt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVEGeBBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BC9C4CEF5;
	Sat,  8 Nov 2025 04:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762574864;
	bh=bVWG8OxlLnY/I8fRElck+WGWHUB5rw/YbxUK/Sy7zcA=;
	h=From:To:Cc:Subject:Date:From;
	b=ZVEGeBBtpfYWfmsA438IAWqCDjX4YFjEokYYn1hoL7NpL4H+OsDoRIXCYETDTnHc4
	 aYgRFSdgQqc5Cp1ZMvdZcZQ/Fo7Pn9zys/WnkTLaOHMiO0+ZHuCG5tue1IQznF0JQu
	 DWFRroKFPNUPao2Xssxr4CBmy3j4TJ/9yEuwVffezUHXigTyjm2u9WACfXytoLp9hv
	 M2GLiczPo3PmH1s/gjmEFNOUw8sAKQLd4k5+1qwDcwfqB0yhKzsLnZW/zHDBGmBwVy
	 LBa5qPyvpgzMNocRIekCzq6zBnb8IhvOaFAG8llEBPPKX0dmzDX8JdPQrzmk9k71/y
	 CchGM8EeVn5rg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-11-10
Date: Fri,  7 Nov 2025 20:07:35 -0800
Message-ID: <20251108040736.74312-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


This is yet another reminder of upcoming DAMON Beer/Coffee/Tea chats
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)
for the week of 2025-11-10.

We have two time slots for meetings in the week, as usual.  The one for
Wednesday is already reserved.

On the week of 2025-12-08, I will travel Japan for OSSummit Japan and LPC.
Attending video calls on the time slots during the week will be challenging for
me.  So let's do the chats for the week without the pre-booked time slots, but
as an unlimited and possibly in-person version.  That is, let's make it can
happen at any time and any place (not only Google Meet but also somewhere in
Tokyo, Japan) as long as we can.

If you have any DAMON topic that you want to discuss with me during the week,
send an email to sj@kernel.org saying you have a topic to discuss, with
when/where you want to meet.  Then we can further adjust our schedule.  If you
also attend OSSummit Japan or LPC in person, you are also very welcome to just
reach out to me in person at any time/place without making appointment.  Then,
we can have an instant in-person DAMON Beer/Coffee/Tea chat.

So next time slots including six virtual-only ones are as below.

2025-11-10 (Mon) 18:00 PT (not yet reserved)
2025-11-12 (Wed) 09:30 PT (reserved)
2025-11-24 (Mon) 18:00 PT (not yet reserved)
2025-11-26 (Wed) 09:30 PT (not yet reserved)
(week of 2025-12-08 is all reserved for virtual and/or in-person chats in
Tokyo, Japan)
2025-12-22 (Mon) 18:00 PT (not yet reserved)
2025-12-24 (Wed) 09:30 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available on demands.

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

You can also get the past and upcoming schedules via
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ
