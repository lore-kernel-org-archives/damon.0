Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432763148CF
	for <damon@lists.linux.dev>; Fri,  3 Apr 2026 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225384; cv=none; b=oGrz0f7MjUGlVhFGDEz3YUjf73gVfNCTe3SnEzequVzA7e2tgacMLmjtRkyXsxvVked+ploJpURaLbPv+3S1E0MYsRy67zctUNHMXuPw6/cRdcBX2+593fxBbi1eRevV8N98kw/mzBnL++OrRtV7mFiPWJR7HcPXSFY3A5haQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225384; c=relaxed/simple;
	bh=njgCd5TgApSbLqL2BVaGVJE3A23Q9YuPZCEfrjmffPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n51zYVdpuc4J0b/w+3vliyYF3PzGQob3iunuMgYbFa8f1VRcsL2Tu6azoMZCJXFmNRmcFB7eRyhsOMHsW2tEDnIcKSs0JTLOjL0LP9eKBnT1UKxvRdtMIZ1AV/ctd3zveSkOOXUk7sR2KGEhhtMujcPprszLa3ofVNste76E0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdojIXK6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdojIXK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6170C4CEF7;
	Fri,  3 Apr 2026 14:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775225383;
	bh=njgCd5TgApSbLqL2BVaGVJE3A23Q9YuPZCEfrjmffPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WdojIXK68rUNezxrGuDGVTF3irivnY5fZ8XHKrTzsat3/aLEvV9fF3cCHdrHorOZQ
	 +Ps2Rsy4srNp/ZNqQExGzLtmp/SmyfrcczIjrpOQxk6gju8amDXnFKqqaZ2JSrj25I
	 PGGnIKnixUABwe+9jyY5pN/ldpsWGXX+O5q1RKT8hq+FvDzORCX3vpx93UuorTh6wB
	 8XFzGu83cCurtM+5SPl1Pdau1bAVWW3ERiD52MeiaNih0xMeAsyFLCEjgLSCMyZlvK
	 Y0zh2AB+UwInJn+614qY2KvWhNNrzcTtiZvBkNECAzlGxhYAaUINHauGHFx1zQ1NDZ
	 6ilPBo5pnDAdg==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 07:09:41 -0700
Message-ID: <20260403140942.50643-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403082910.5346-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  3 Apr 2026 16:29:10 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> Sorry for missing the discussion before sending out v3. I was too
> focused on the code and missed the context of your questions.

No worries.  From next time, please ensure discussions on the last version is
ended, by replying to questions and waiting about one day for giving others to
chime in, before sending the next version.
[...]

Thank you for all your answers to my questions and requests.  That all make
sense to me.

> 
> > 
> > [...]
> > 
> > The code changes look good to me.
> > 
> > [1] https://lore.kernel.org/20260327062627.66426-1-aethernet65535@gmail.com
> 
> Thank you for your review and patience.

You are always welcome.

> 
> [1] https://lore.kernel.org/20260403052837.58063-1-aethernet65535@gmail.com


Thanks,
SJ

[...]
