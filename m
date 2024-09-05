Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0131714B8
	for <damon@lists.linux.dev>; Thu,  5 Sep 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559726; cv=none; b=NRgwQac5nDUCiUw6wKhRGIFqhXhQBrj2svuVtUCaOOQlFmuM8bnfvWLhqpIQoA6a1MIsHlF1eZio3kR7p+rRvhGA89CYcUv5x5++z8zfxn46v0wYnfLSkR3283iKmq+x2pnisRr5CYcyzSDYq4qatQODptwQTKPcd7aUXFtkAzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559726; c=relaxed/simple;
	bh=a6IBH9G5lUNgw3qdxUIfp/AghiRGsq/RnwQ4EvituhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCbubf71uE5CZGj5qa/7Ai4ZcArrCv/LfYHYJJmeY4fdy+sqtHkjf+0+53cOB3ovDuOjGyNlTflkrO2CzUEsl8MPyYB4T8BHVAZ2XKKR0Fo08bEA7JzbhKdarV78nbAPHuRMNLrVW1gbOhoJJnstHLlbAo8TzPP0e9hldRZNTdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFFf9nmh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFFf9nmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B65C4CEC3;
	Thu,  5 Sep 2024 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725559726;
	bh=a6IBH9G5lUNgw3qdxUIfp/AghiRGsq/RnwQ4EvituhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFFf9nmhSyRPxCjIujDxn9HWCcSJNUViywFqMEb4qYV3yfkIA3PZE9YSBQJDIOLiK
	 ruPfKaksAKfC11kO9uhzUO337W+N+ghOiO075XGHr+4REZbAwoicc+1TC/mHBMSChZ
	 c0vp2Wopz13A+xrOgL4t5Q72ZPTsH6fmK0t6aZPCFLUGmoBF4dXuFlOuCCsoEX0sbd
	 0AKAfLvPrM/rtDBCvQAolKoXMhTz1p2AIf08Yy6OejFbAx92GwaGCipAmlX5NZv07j
	 Jy9OtfyICVYBjzEiRT8MjU87Cf1XYZ6ywVUq56sf1oLK/2ZifQVhTBJftr3VDV94Mp
	 hrgXjkcmBvJrw==
From: SeongJae Park <sj@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Problems running DAMON kunit tests with spinlock debugging enabled
Date: Thu,  5 Sep 2024 11:08:43 -0700
Message-Id: <20240905180843.46016-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <64f1b6bf-174f-4ac2-a43c-2783c1cd3999@roeck-us.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 5 Sep 2024 11:04:51 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> On 9/5/24 10:35, SeongJae Park wrote:
> > Hi Guenter,
> > 
> > On Wed, 4 Sep 2024 14:04:03 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> > [...]
> >> Here is another problem. With all other problems fixed, when running on a 32-bit system:
[...]
> > As you also mentioned, this function may better to be significantly re-written
> > with overflows in mind.  However, I have no enough time and setup to
> > sufficiently test the fix for now, due to some personal reasons.  Also, the
> > issue is important, but not time-critical for now, in my humble opinion.
> > Please let me know if someone has different opinions.
> > 
> > So, I made one possible fix off the top of my head, and posted as an RFC patch:
> > https://lore.kernel.org/20240905172405.46995-1-sj@kernel.org
> > 
> > I only tested that against the kunit test on my 64bit machine.  After I get
> > some time and setup (maybe 1-2 weeks later), I will take more time to review
> > the code, do more tests, and post RFC-dropped version.
> > 
> 
> No worries. I queued the RFC patch up in my testbed, so we should get results
> for all targets later today (or maybe tomorrow, the testbed is busy with stable
> release tests).

No problem, please take your time :)


Thanks,
SJ

> 
> Guenter
