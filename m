Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADAA3EA949
	for <damon@lists.linux.dev>; Thu,  1 Oct 2026 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861280; cv=none; b=FBVCEbwVNzIGlQ8dpEdVPTV5Y1W5RnLsbkJVQSEn1uK+rfTtX/vwVHp4QCF6Y1LyazvjnuVpP6lnUqmO4sCYFFv3t31MP4pt8e2xQ3G0yONCU00Xpd3RD/sjMYNvCRMWhR+1Sg8B+b67ESjyCAEjWBiVez5BEbCSXTsdGRwxdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861280; c=relaxed/simple;
	bh=Pt1OrNvoxdgA7BFeun667a4g/FXS9zgsYCDzNrtfdJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVpdCfT1AoDS3sSsBttXNMvv3/UO4hvZpwiLskhEBJkx/Hzbj/htAThGO/w3l9k8POimnLYZmIhExwGK4eX15sUBvqQqlH6EAPa3hAw8WBt7/fMoUbSoKB63i+DVAwSAULhV+GaKWMnViv9gfNgK5DuiqkrHsY4sapXL0NVeyqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muyatSN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muyatSN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD331F000FF;
	Thu,  1 Oct 2026 13:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790861278;
	bh=AiA6DvY9sFx97JxEqHjMS/UX+tphwXgGr9QEESjXOzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=muyatSN6+TiREny5dOLbch2eHiwVZD0G2eDOh9Iu32pfnjN2+KTMnEptFyTIXJF9w
	 foMsP7Q6XxkBqcDu3EKx7/PN62mAiMD8zS9299SDt13BJgQhpPfElPOdFLce45T1II
	 kVX/Yt6EWG3m4YDfyB62twQsKiFf4igZ7CdKbO7rVB7gHs27q8rSeYOSBpBTUI3M0d
	 hNmhu44rHuDSCRIS+EqfVUd0afw5rLaA3jWKCsdBSwVJyfMyr5d2Gr4Vdg9231/3c8
	 BKVNfh4JiXGlfFFTkpyBxQzqnG0OHlSXgEJghP0mG5HPb3x7dPJLkWhQ5+gQ4PyAz8
	 RryWUy8TfqEhw==
From: SJ Park <sj@kernel.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
Date: Thu,  1 Oct 2026 06:27:54 -0700
Message-ID: <20261001132755.47167-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAAiJnjp40164tbVXhJ9rP4J0UP9m9r4_Zo2phBvQ64pCzpxS7Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 1 Oct 2026 15:08:38 +0300 Anton Gavriliuk <antosha20xx@gmail.com> wrote:

> With your support, my progress tremendously faster than I expected :-)

Thank you.  The pleasure is mine :)

> 
> Moving forward.
> 
> In my VCF9.1-like example Demote/Promote bandwidth is limited by admin
> up to 8GB/s.
> 
> With CXL/PCIe 6.0 it may require moving pages between tiers 10's GB/s.
> In this case, kdamond single CPU core limited or can use more CPU
> cores if/when required ?
> 
> ~1 year ago I played with AMD Zen5 9455 and 12 channels 6400 MT/s DDR5
> DRAM, single thread core-to-local-memory bandwidth was ~49 GB/s.

It is basically limited to single CPU core per kdamond.  You could split memory
into multiple address ranges and assign kdamon per the range to utilize multi
CPUs, if needed.  SK Hynix [1] was using such an approach.

That said, I'm personally curious if such fast migration is really needed in
the real world workload.  I assume the real production workload would have
stable access pattern but only occasionally get access pattern changes.
Sometimes temporal and rapid access pattern change could also be made.  But for
such temporal pattern change, doing migration would only be costy, since the
data that suddenly hot could be soon be cold.  And reliability is important in
production.  Hence I was thinking slowly making the balance is better than too
quickly and reactively making migrations that will turn out to be no really
needed.

That said, if you want to test faster migration speed, the multiple kdamonds
usage could be one way to test.  If it turns out it is really needed and
splitting address ranges has problems, we can consider adding DAMOS feature for
utilizing multiple CPUs for faster migrations.

[1] https://sched.co/2913n


Thanks,
SJ

[...]
