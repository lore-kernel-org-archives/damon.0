Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC0C137E;
	Sat, 19 Oct 2024 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729379609; cv=none; b=fq/83XHZ9BCA+VlE+2sokpr2I0aRUUfBPO8UZ9uS6EwZtS0Ei1DK2vAGClyiASb/uj/uFqd9t/k4xsTGLl7kR8k/ZuKDRbxahwKHUkC87FFYWhYjrp6nEcvxGb5jqgWxN6D5FO8d3EnhbtBWq8Vm++bEvOmoHhJu1leDFOTmSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729379609; c=relaxed/simple;
	bh=vWUeb4y4cuKpHehQY2zJm9jpvextoPdgt8ZZCnuZFUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5OJ4J506LQlv+gOviqWJM6GQnuQ1bSc7JTpJc/+sJ9cdqK2+dIapW7ufoKDuHabpPNobnTR02szVCUpq568vtvFXxjSCCsiKtfh6oE/yddpPBGhOKknm5FE40q7K5A69ONU5fLX4RrpHq4AmuxangXLEpeQr4CqqH94XS1BmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZQ5rrQp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZQ5rrQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB056C4CEC5;
	Sat, 19 Oct 2024 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729379609;
	bh=vWUeb4y4cuKpHehQY2zJm9jpvextoPdgt8ZZCnuZFUc=;
	h=From:To:Cc:Subject:Date:From;
	b=FZQ5rrQpQqtiKqZcbUQX2jPLTNEwdt9YCYvhmbRDlv/ihOII9I3F4T/1Hx0nwIv79
	 huL/NQqdhbvx9yO/osINQHWiPlus7wUinWpEZ3HhSHl9VbwQItgDo7BAqPr5wdjbk2
	 +LYRhqEnO+AIu54T1/9Qfdp/+fkbmrT/nowVBv6v6KU2RBJM03m7ovaRbNz7DI0fSc
	 4rQ6D03mYdLFenH8uTVBGpAaUMkcWbeXX6AtYuSn6wehY8e4N8WsqfI/5T7r5hce+q
	 d8iObuHoHyiHRiiuQ+8XRG8PIm4Yp2ZhjaymP56s8EIb2h73xx4jXHjjIM5NkbdBEt
	 +K1b2vT/WRyAg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2024-10-21
Date: Sat, 19 Oct 2024 16:13:26 -0700
Message-Id: <20241019231326.72299-1-sj@kernel.org>
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
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing).

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2024-10-23 (Wed) 09:30 PT (not yet reserved)
- 2024-11-04 (Mon) 18:00 PT (not yet reserved)
- 2024-11-20 (Wed) 09:30 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available based on the demands.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2024-10-21 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-11-06 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-11-18 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

You can also get the past and upcoming schedules via
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ
