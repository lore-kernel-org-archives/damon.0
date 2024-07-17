Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09824D9FB;
	Wed, 17 Jul 2024 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260696; cv=none; b=q9WcNoTaoAqch5D+Zw/0S352LuWafE3cAf7C1cknXhpJ3jAmQZk5MCibsXWRMXafEY65bPUwV6fPHRaIODiJRFISAVsviplZg9T9DRUGg0S9MdKphN6sgIAmAScctUb4I+lzO1I+O7JjtS3lecRFf2g7FGCgq3cDDQ9cVHGLpko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260696; c=relaxed/simple;
	bh=5Wb2eZKJTz/jMDi0+hRmInc57d4u3ci6Qfq5xiAAwcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yxwpp42e8fB+G87JHST1gITiBZsIbBq7RwzQgJK4Fr7fpluSP32V3QqccVD/VcoJTKpdYCD9mimZ/th+PpiDgKhCF6MAaXLU9z/4PuCS9P78dGtIq0mO14zYAyeL5e4M/NAcpNfN44AvHP6V8NLnw/gwS4EW+hFiShvcIwOlw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjE8lgFR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjE8lgFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F02C2BD10;
	Wed, 17 Jul 2024 23:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721260696;
	bh=5Wb2eZKJTz/jMDi0+hRmInc57d4u3ci6Qfq5xiAAwcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjE8lgFRopw7Cn/Zf4QpeH3IVOgETO8Nw0pYO+kX/kLpBo1fRObZB7tYHh6JLxUuy
	 +uVrGxf9jL/dGUSo/m3jBP7MN8+HEgJgwQaMH71ekUAM/svfFEl89IX51aME/ryUE+
	 9AwGPXhNVNOduPy3MoY6AuaVnzMwxdEKQPSdtB48Bo6qyxMyUUtorIJaBHTKWw9Sfb
	 MEvRDvQ14u3KzsovByPSB8NRbNnh8S+AEagsYIEB4bkQ/FPYjf/uwTNJSdI0Dhz7jW
	 wySijyUhaUthdeyPGe0P+Bj9A3ZHRTM9CtQhnnG1eud/YOLQuTrEc0bykG8KcUT6qQ
	 G5hh4hreyCh8g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Shared calendar for the schedule (was Re: DAMON Beer/Coffee/Tea chat reminder and extending for office hour)
Date: Wed, 17 Jul 2024 16:58:12 -0700
Message-Id: <20240717235812.53087-1-sj@kernel.org>
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
> 
> Recently I got some feedback about DAMON Beer/Coffee/Tea chat.  They told me
[...]
> Firstly, I will regularly provide reminder of the series, probably 1-2 days
> before every instance.

I usually send the reminders based on Pacific Time.  Some folks told me it is
easy to make time zone difference calculation mistakes.  Last meeting, there
was a further suggestion to have a shared calendar for the schedules that
handles the time zone difference.  So I made a Google Calendar and added the
open group chat schedules.  It should be avaialble with below link:

https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

Please feel free to add it to your calendar to get alarms without complex time
zone difference calculation.  If it doesn't work or you have other suggestions,
please let me know.

I will continue sending the reminders, though.  That's for new comers and
people who don't want to add something to their calendar.  So if you're ok with
current reminders-based system, you have nothing to do.


Thanks,
SJ

[...]
