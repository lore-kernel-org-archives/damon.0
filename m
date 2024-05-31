Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93C81725;
	Fri, 31 May 2024 22:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717195358; cv=none; b=H4R3OyUGPvsHKEpC2d/C7SRHSK8jyspTYYt82Knz9hcM/jV45lpDBQCmF1Be7rf/N4rwc/gSyLYpjp/Ax1BE/RTdlvj0CBgBuI9PZoAarzTOpCZdYLd9N/9MLhctlahIguiELyWFeXlL5xhCRKcCc21eWiNSCQ34H/P1j+mFbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717195358; c=relaxed/simple;
	bh=7zF3CS0HwYvM3iooAVRuWZ9UN5V1zSwJaf5ULg6cuII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBANnegcNUwByXErCmz3jNY1fE4mbQHP6wTARWpUwgZNaNLywIdpcSbNrBNC0RGbdZWuGUEkshuGUxdJqyTEAdvBF35HuMz9sGwNnbT0hG4itLBEEySTCrt3gGQrJpkg7Y6VEajW7FHbQRTjz+G8AnsDrvUhC7LhHJzDXqSaXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI17MET9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI17MET9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8A6C116B1;
	Fri, 31 May 2024 22:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717195358;
	bh=7zF3CS0HwYvM3iooAVRuWZ9UN5V1zSwJaf5ULg6cuII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XI17MET9YKdgUcaH9FMjW2rKgyOk5QYCyJZBsqygIBoIQNsv77Gt++Y737injy/Ti
	 nUZHG1qi/zaeL/VmNyMQiDQQIdQe4Q8qjS66vu6Nvhp+zrf406s+PIK24Jxd8EJv9J
	 R1KHQuRIo//fXjB2VLkUPXuDJ+oFGU3Pxwd6ZwjQRQaS+nEkAnSD6tUzM7V0txXekL
	 gZ/BOeMLfV/ouF6wdajbY0hiUOyyngeuURBfKWJLJ5tD2bZS9GCajLgZAY0Yx/n9lD
	 ppnbO7I7plq7KIwEXyidtigBg3rSIAHrA938A4BH7j5UuHh/MXj2zNWmlbEnL1TUAW
	 VdZ6H2PExZmrA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat reminder and extending for office hour
Date: Fri, 31 May 2024 15:42:35 -0700
Message-Id: <20240531224235.77599-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240519163329.150340-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Sun, 19 May 2024 09:33:29 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > 
> > In short, I'd like to start an open, regular, and informal virtual bi-weekly
> > meeting series for DAMON community.
> > 
> > Important links and dates
> > -------------------------
> > 
> > Location: https://meet.google.com/ndx-evoc-gbu
> > Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> 
[...]
> Firstly, I will regularly provide reminder of the series, probably 1-2 days
> before every instance.
> 
> Secondly, I'm extending this series for reservation-based office hour.  That
> is, I will reserve my time for 30 minutes every two weeks, keep the schedule
> public, and encourage people to reserve the time for discussion on a special
> topic for them.  The reservation should be made at least one day before the
> time slot, and will be first-come first-served basis.  In detail, I will
> reserve Monday afternoon or Tuesday morning of the group chat scheduled week.
> Note that this is not necessarily only time slot for such discussion.  You're
> still encouraged to schedule private meetings on your convenience.

So, the reminders.

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2024-06-03 (Mon) 18:00 PT (reserved)
- 2024-06-18 (Tue) 09:30 PT (not yet reserved)
- 2024-07-01 (Mon) 18:00 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available based on the discussion.

Any-topic discussions
---------------------

Next two chat instance for any topic (no reservation is required) are scheduled
as below:

- 2024-06-04 (Tue) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-06-17 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

You can also get the past schedules and upcoming chats any time on
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ

[...]
