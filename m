Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242811DF254;
	Sun, 15 Mar 2026 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773609280; cv=none; b=A0qMvUKtpGwM9gtiXEiQD7mz8bBmAwlx+Q+2VQuvpLriL3BXHRdPd0pyYukuZCvuoWQNh2isPPo26xbJlLmAcRDM5i3x8XKmTxiZWrdbS2aaL3dIe4BSjlEl/ucuF6ZAmvUSWGXF/jPr4vf6zQOJezW2EI9LAHb6CTtztg8Uc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773609280; c=relaxed/simple;
	bh=uhn2s/HJkqr7A49NC+rhbMTs/mAUE6GqP3N9LZ6XXmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvuTs5ypYWA9xayRFbS/17/dqZqwo5kzzcLldvsKmdS0JovhaMZUBH3wHqZvAK01qqXazjRX326fuPZyTT5CnPNEy8UPvAdbJNmLtePxR9z9gMIMTadtWhxykMw/96SF/fOMYRvEOT2RbYChCGychlbyaf/GvWjg1a0gdsG5mTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmW7vWl6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmW7vWl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E66C19421;
	Sun, 15 Mar 2026 21:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773609279;
	bh=uhn2s/HJkqr7A49NC+rhbMTs/mAUE6GqP3N9LZ6XXmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmW7vWl6AJnezLaYhB0d63lzQd3Ov9cuP/DxQmksegSp/7uLBuMO/pjNmsadMB8Hz
	 xMqN4SXjv8AXBDec8vH4RhM5WonU46PZVJCrQLrplxnoSPpSur4t6ac2RNu/J+Y360
	 rBgJC6tKnjasRuMbDVos8EoZCO8JORtULbWNEhlTr8TV9CEkduQ+Ow/sHKuOtgNeid
	 LBf+gHSV17VWRK0xDNBVBlDxxR3iCvaYwtA3eD6RonMGKEidTVuVozbmiMvCy89FFN
	 UbV0/6IC9o8Yf1bl6yZKF2197KVWDTA3nCUw/Nrc4p3QnaGx7DsYoWtmZdPIIOSTnl
	 eQGTogQwBqb/g==
From: SeongJae Park <sj@kernel.org>
To: cuiyangpei <cuiyangpei@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date: Sun, 15 Mar 2026 14:14:35 -0700
Message-ID: <20260315211436.95385-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20231201122507.GA15806@cuiyangpei>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Cuiyangpei,

On Fri, 1 Dec 2023 20:25:07 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:

> On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> > Hi Cuiyangpei,
> > 
> > On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > 
> > > Hi SeongJae,
> > > 
> > > We also investigated the operation schemes you mentioned, but we don't
> > > think it can fit our needs.
> > > 
> > > On android, user will open many apps and switch between these apps as
> > > needs. We hope to monitor apps' memory access only when they are on
> > > foreground and record the memory access pattern when they are switched
> > > to the background. 
> > > 
> > > When avaliable memory reaches a threshold, we will use these access
> > > patterns with some strategies to recognize those memory that will have
> > > little impact on user experience and to reclaim them proactively.  
> > > 
> > > I'm not sure I have clarified it clearly, if you still have questions
> > > on this, please let us know.
> > 
> > So, to my understanding, you expect applications may keep similar access
> > pattern when they are in foreground, but have a different, less aggressive
> > access pattern in background, and therefore reclaim memory based on the
> > foreground-access pattern, right?
> >
> 
> Different apps may have different access pattern. On android, the apps will
> join in freeze cgroup and be frozen after switch to the background. So we 
> monitor apps' memory access only when they are in foreground.

FYI, I just posted an RFC patch that might help this use case.  Hopefully the
cover letter will explain why I think so.  If you need any clarifications or
have questions, please reply to the RFC patch series thread.

[1] https://lore.kernel.org/20260315210012.94846-1-sj@kernel.org


Thanks,
SJ

[...]
