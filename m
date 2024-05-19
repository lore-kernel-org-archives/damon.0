Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85E33D5;
	Sun, 19 May 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716136412; cv=none; b=XqLqZDzYV5ee6yTnjB+D7kowM57C/cOeiN4EetNA/pzuorbyibDPRTPwD3zo74A+iqRKT9cmuMjNOWGWWla7uoMQ+HSQ02MVdstDHUK3w6G/6pZcocvBKa06U57xFKo0xDWI5MWEibj9nsvKEOcGOnZ/NdoWLHmGi0FY1kAr9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716136412; c=relaxed/simple;
	bh=fmMSUyNHsE6VoUCYl0X/LyZxkscRpgZwZMpd5XJNtEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kgje7L7wXEl6GxZucUZkMAvP/eHMrfb9jHjsjnqdPKnLToadlEU3sQPJ1njTSeRKg1qwT7xI8RTzhLVZmP3ilYb+wPksZ29xf9mVd3OPUAq/1LSNbNZ+i2h1/kBh1Cwj9Mw1f15CJ4TTRPSMz13RHMT0vydQts6jnc/GRBlVu1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA0TvzOd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA0TvzOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15CCC32781;
	Sun, 19 May 2024 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716136412;
	bh=fmMSUyNHsE6VoUCYl0X/LyZxkscRpgZwZMpd5XJNtEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LA0TvzOduIiTuOsOJhkeQWTJCtEG/htBtBgK7tt1AFrnZW47/44pX6laki5jNG1LX
	 nLztUHKT/RiFU53d4cPnOiF9UKmcXz09BkAjDSotJ5yg2pfV9KrCn3MBAfDVTluqLs
	 HsuBWui+DAUDdcy9X5EzY6hCQl8XCRA1G2W8kPoY3Xy/jhpHfK2LTwcH0pWYfwqBeD
	 PqRi9Ara5zLpGbLFLpR2eTRObz4/9jXALrHt3vrWidICdJBqab2uJ+Syxygk+y3ILj
	 eMBTLlyzDpoBGJcIYAtXEhm440Rco2GwDN2BBm7aR9KAXiIkDNP1neqG5CFeW7vrlb
	 y4whcdOceXPqQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder and extending for office hour
Date: Sun, 19 May 2024 09:33:29 -0700
Message-Id: <20240519163329.150340-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> In short, I'd like to start an open, regular, and informal virtual bi-weekly
> meeting series for DAMON community.
> 
> Important links and dates
> -------------------------
> 
> Location: https://meet.google.com/ndx-evoc-gbu
> Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Recently I got some feedback about DAMON Beer/Coffee/Tea chat.  They told me
having regular reminders of the series would be nice, and official time slots
for private discussion could be helpful.  I encouraged scheduling private
meetings for such deep level dicussions, but I understand it could be more
easier if we have more official things for that.  Hence, I'm making below two
changes.

Firstly, I will regularly provide reminder of the series, probably 1-2 days
before every instance.

Secondly, I'm extending this series for reservation-based office hour.  That
is, I will reserve my time for 30 minutes every two weeks, keep the schedule
public, and encourage people to reserve the time for discussion on a special
topic for them.  The reservation should be made at least one day before the
time slot, and will be first-come first-served basis.  In detail, I will
reserve Monday afternoon or Tuesday morning of the group chat scheduled week.
Note that this is not necessarily only time slot for such discussion.  You're
still encouraged to schedule private meetings on your convenience.

So, the reminders.  Next open group chat will be held 2024-05-20 (Monday) 18:00
(PT) on Google Meet (https://meet.google.com/ndx-evoc-gbu).

Next reservation-based chats are scheduled for 2024-05-21 (Tuesday) 09:30 (PT)
and 2024-06-03 (Monday) 18:00 (PT).  If you have some topics that you want to
discuss with me on the time slot, please reach out to me for the reservation,
at least one day before the time slot.

Every meeting is 30-minutes length by default.

Entire schedules are also available at the Agenda doc
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)


Thanks,
SJ

[...]
