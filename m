Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4730677B;
	Wed,  3 Jun 2026 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780462949; cv=none; b=AXV6fyhpmjA7a0MnfrVSYyyjNaauv/Z0rFOuPB7P59XmkJfvv5et+2tMEmSI6R985SZOhaZIn1suRvi4qgqFuv3YS8oFi+kUcKZriL+v5RFBcexmrvT0dc1CBgocFmky7uWWu5SY8G2kFTgfHXYDSTiK+iG/7i4Yii9gK6yCTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780462949; c=relaxed/simple;
	bh=2PUHrCxeP5dsol6J6UIML0UNV+IbjUpNVuM2Zm/i+Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+FHMAvF9GwOb3P6gpjnbq3UIh7+IUfG1sTIuAQz83Pp3LP0usoudOdQL6FpOtQckiesUiNz5Iu2njNC1Kof5nT5lh/zGxPmarFKw5VSoElfc8ndCuARZHlRYJcIyZhZtlM+LMyEMbEXvi/PyzKTI1SZruDQMKxMH/0PaV/gpzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+RKWqMk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+RKWqMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9C51F00893;
	Wed,  3 Jun 2026 05:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780462948;
	bh=4sJhmtviZHBbmBaKNClEQj/V4FOUrUEB3D970WV899Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K+RKWqMk+jTeJ5BUw1Mjx/ggb49btY5HQA5mm+Sh/UIoiRQI6hiU7QUvIr5C+FGRi
	 GNFosr3VGPP5K7hgIweNsn36xIsrAXTrUwsEAFuHJemOSJTYT8S8BQmC+dvpknLScT
	 rVYB95PUEr02nDW/Q2ZzauN1yu+KtpJM+nrA8hjWo5MWaPzEi/cN0swbcqgCn79SKz
	 GE6Mhy+qGaO9aNpPOGcEC4j7DOQ5llS+vQjsTHLmoDMt2D4ZOYF+iQr642n9cGLk4C
	 E9W9oAxe0mI1Y8QA4JSWbUYWDUu0lwEbWM+Y5TepMcAK0h1sFQv6l6e3a8Z63wMsAY
	 sjDrtMoCpIyMw==
From: SeongJae Park <sj@kernel.org>
To: "Kunwu Chan" <kunwu.chan@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Kunwu Chan" <chentao@kylinos.cn>,
	"Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/3] selftests/damon: misc fixes for test bugs
Date: Tue,  2 Jun 2026 22:02:17 -0700
Message-ID: <20260603050219.91743-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <38c4d77974349f9783478a04c46df6f975d41c84@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 03 Jun 2026 02:11:33 +0000 "Kunwu Chan" <kunwu.chan@linux.dev> wrote:

> 2026年6月1日 22:22, "SeongJae Park" <sj@kernel.org mailto:sj@kernel.org?to=%22SeongJae%20Park%22%20%3Csj%40kernel.org%3E > 写到:
> 
> 
> > 
> > On Mon, 1 Jun 2026 11:23:11 +0800 Kunwu Chan <kunwu.chan@linux.dev> wrote:
> > 
> > > 
> > > From: Kunwu Chan <chentao@kylinos.cn>
> > >  
> > >  This series fixes several bugs in the DAMON selftests. Most are
> > >  trivial but cause tests to silently pass when they shouldn't, or
> > >  fail prematurely on slow machines.
> > > 
> > Nit. Only patch 3 fixes a fake test pass for "avail_operations" file existence
> > test, and the series is not doing something for slow machines, right? I think
> > the last sentence should be updated, for example:
> > 
> > '''
> > Most are trivial but makes test output wrong or even silently pass the one for
> > 'avail_operation' file existence check.
> > '''
> > 
> > Other than that, all look good to me, and already have my Reviewed-by: tag.
> > 
> > Asssuming you are ok with the above change, I applied this series to damon/next
> > [1] tree with the above change. If this series is not added to mm.git in short
> > term (~1 week?), I will ask mm.git maintainer (Andrew Morton) to pick this.

FYI, we are now quite close to next merge window.  We want to focus on making
mm.git more stabilized and therefore ready for the next merge window, rather
than adding more changes that no really urgent.  I understand this series is
not really urgent.  Hence, I will request adding this to mm.git after next -rc1
release.  Let me know if you think this is really  urgent.

> > So, no action from your side is needed for now. If it seems I also forgot
> > doing that or you cannot wait for my action, please feel free to directly ask
> > that to Andrew.
> > 
> > [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
> > 
> Hi SJ,
> 
> The updated cover letter looks good to me, thanks for fixing it.  
> Thanks also for applying to damon/next.  
> No further action needed on my side.

Thank you for confirming!


Thanks,
SJ

[...]
