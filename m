Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D2175BF;
	Sun, 15 Dec 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734292966; cv=none; b=gKJ+5jI2bc/G/nKEr2WoEl/FJtrvn/Mjpmr8WGjuntlKA8No8+7oO/lS0Ri+od/Tr+IoLTkD5idrpCD/Cj6Z0iPuCeL0bIHoOpxX3JVmBxLFUVLi5d2qxRhQkoyrRKbIfb7A3DkNT/vP1U9qJitWgAmRstyoTWK39Q87qeMK11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734292966; c=relaxed/simple;
	bh=MfIWA0mL3UFSXZeNbdo5DmBQRZv7A44damBr44affXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UR1IJzg+9lec1cPTaktAjKgnvSLCWhBmjOmKbO/VAJdf+UAvCq/cj0HwbI/Sb8XXBX+iEBy58YwcPdxILa8Owe+kii8NZksQ/m3RbfFVJmyOh87ISf0dwRItL9Kiaod3jQApvRzOmwlJjRc+wmTyuACpmD1umzRahMDKvoItmP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXrECkyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXrECkyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EB8C4CECE;
	Sun, 15 Dec 2024 20:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734292965;
	bh=MfIWA0mL3UFSXZeNbdo5DmBQRZv7A44damBr44affXs=;
	h=From:To:Cc:Subject:Date:From;
	b=MXrECkyYm3T6zmPV75aFlqNOqqUnTEPKfSY8WSGfdr7tAArXyeUmB96yuJjtsSTDr
	 d1VaqonSzwi76VOiwQj+Yhpnwi1Ba6ybNs4BRQ62/RBQ0TIXqKZAgntb02YSaBGDt8
	 EgspoF2sMu08hVC0TNBRDvvDH9gvGU9QSUcpdEYgmGdEiWLYDSn+cCuB7wz7/nMKnJ
	 hBrFjtYNuNFEKgw3QIRddvlSh01kdqk/CuHNqxpl5ie6Eo2Low/JiP/UVJS1xp+nkZ
	 JwixsjWkvXReVMPSYW4vFY/Q+p7Ubs1A07sG/mmlm1OKf8Hfldb09yOU4Tbkz5VTys
	 gJxdBhofjkgig==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2024-12-16
Date: Sun, 15 Dec 2024 12:02:43 -0800
Message-Id: <20241215200243.72079-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
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
for the week of 2024-12-16.

We will have the two meetings in the week as usual.  According to the bi-weekly
schedule, we will also have the meetings on the week of 2024-12-30.  Since it
is the mid of the holidays, I will just cancel those, as announced before.  So,
next two meetings will be the last ones of 2024.

Please feel free to schedule a meeting with me if you have any topic you wanted
to discuss on the week.  Beer/Coffee/Tea chat is just a time slot that I
reserve for convenient schedules, not only place to discuss something about
DAMON.  Of course, mail or whatever is also ok :)

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2024-12-16 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-01-13 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-01-29 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2024-12-18 (Wed) 09:30 PT (not yet reserved)
- 2025-01-15 (Wed) 09:30 PT (not yet reserved)
- 2025-01-27 (Mon) 18:00 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available based on the demands.

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

You can also get the past and upcoming schedules via
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ
