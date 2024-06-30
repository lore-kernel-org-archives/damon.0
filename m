Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B32C6A3;
	Sun, 30 Jun 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719767385; cv=none; b=rjh+GodiTT7nZMTl/AbA5XsWvd8mJc5SaW3/8/Oe5+P11ZSaZ/KcWpAFaUI4Exr8GS1nNDu0iKwwhXfoC+LwNk7B0Zv7F5CL/dRwX7GwNhPz7j4JaHan0/SNS/iNts2Z0jbKgpwDxIX2nv5zdlef39ZVqxfhv3JBCvRvG3UgPGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719767385; c=relaxed/simple;
	bh=AXBlazSLshLFAHubtMq7lRMspI5WG6BHny2zXhcUn88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnQy8zgU5pif2cFef+QHbfIPvk3P6zt8ZhaKKQemXH4H8HaXrEAPRrtBU5QgNNaIbZyIcjSeE3F6tJhQH2GbPLbWqX1wCjCjoHuSiaNKmZNO3b1kvMb+YyMONpH+0M4Y7xJDPngFtFuqoqMV9omhNJcOwuFb8x5AJAZ9lsddxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxtIxssb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxtIxssb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C0CC2BD10;
	Sun, 30 Jun 2024 17:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719767384;
	bh=AXBlazSLshLFAHubtMq7lRMspI5WG6BHny2zXhcUn88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VxtIxssbrf0mbZusZn2VmKXc+ljkTodJNVAmUkvBiJlKBfwLQ82aoom8jgNiO5aSI
	 1Q2Ns75lWjA4DdFKkt2dYg/ZJ2uYRVwq5zJQIsE3XO1n8eo9qo0Dk43qVQ6jG9kNxo
	 hIjgeUBI/KpRIJ2JR/vf8Yr4JNO8b6z9jUgqgqiiw6H7wOPncqlzYOOZN6TDsMJpLi
	 Nw4ydq1kn8mM8pONSobMX5N8rivc5F8eUHsn1Uv8byEulEpeXvq1M1yjJKRIIQ2HfQ
	 xxKNtvCC4L7WVcAYaLPLO4ByA9T6rcS8n2MnyjGOTZTIuCf2mdc+jgTztiAoQ2aPp0
	 Cownkt7euxpxQ==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat reminder and extending for office hour
Date: Sun, 30 Jun 2024 10:09:42 -0700
Message-Id: <20240630170942.82099-1-sj@kernel.org>
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

So, yet another reminder.

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2024-07-01 (Mon) 18:00 PT (reserved)
- 2024-07-16 (Tue) 09:30 PT (not yet reserved)
- 2024-07-20 (Mon) 18:00 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available based on the discussion.

Any-topic discussions
---------------------

Next two chat instance for any topic (no reservation is required) are scheduled
as below:

- 2024-07-02 (Tue) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-07-15 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

You can also get the past schedules and upcoming chats any time on
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ

[...]
