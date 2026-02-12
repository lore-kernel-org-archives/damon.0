Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10272BCF4A;
	Thu, 12 Feb 2026 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877819; cv=none; b=F4LlI3LJgQU6q+Qc7VmwIbEbzZn71ZIlmvADhNKYAO7S4lWzlg/97KW+GWFQTn430/D+6HxiIvCBB4xymJlpQ755JYs/q0LD/IITcTUZwzL0qJm3mTjP6o5htTxla825nqjEhSJ8rVQAFdzrfLxKN1Ayps0hBGCKtHyf+VFnowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877819; c=relaxed/simple;
	bh=pW8zfzWPeGX/NrtwmdEhpxnSoeYoudMU3BLTUgjZrks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfJcsUgVwtd9AEgC/yC8mEMNlr24NZ8x1mwJnbAKFqVz+TKlDR1EvjU6BTrHUpf7IY+Xhk657XdDEDlfgaUGpEncl5ryWTba1trvHjELcJxw1wCBT6SlCQ011GVWq560nI0x7wxqwbMp8msenmqJtzH3f9oPOR1+6tg7SFmtsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQdBVOoo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQdBVOoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242F1C4CEF7;
	Thu, 12 Feb 2026 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770877818;
	bh=pW8zfzWPeGX/NrtwmdEhpxnSoeYoudMU3BLTUgjZrks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQdBVOooaa7gvsHwCnljCEeeqnL5QpFI2pjxdkuOhWGIEotMDtyThVuqfFrInzeuV
	 O4IcwF9shTMX1YwjINUlOxQM2lS0ErJaA8l4N6XfwEg7iOa+zbpSJUoqI5iTMTUSbd
	 YAPdYaOdB00uwiS4P8jHqDvM2yf6sdbPhO04G8+vTPuf36/K/eH0TcOALKwTiQva1o
	 Y3ynfsSnA2nPfOL12U9AGX3Cu6y17fApeKRiqjJU6rl0Q78XLIcJ2nEm1I00E+ont6
	 F1+qnVYq5go4sNdsolG7zxUHNOZf6ezLtrSp9oy4r6K59hVWDxz2SxfShHjRCFqCDL
	 qSV9vCKFTRzhg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Yunjeong Mun <yunjeong.mun@sk.com>,
	honggyu.kim@sk.com,
	kernel_team@skhynix.com,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com
Subject: Re: [RFC PATCH 0/5] mm/damon: Add node_sys_bp quota goal metric for
Date: Wed, 11 Feb 2026 22:30:09 -0800
Message-ID: <20260212063009.70556-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260204060641.97191-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  3 Feb 2026 22:06:40 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Wed,  4 Feb 2026 11:25:35 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> 
> > On Fri, Jan 23, 2026 at 05:50:43PM -0800, SeongJae Park wrote:
[...]
> > > IIRC, SK hynix people also confused with the behavior when they experimented
> > > migrate_{hot,cold} action with NODE_MEM_USED_BP goal based quota auto-tuning,
> > > but using only a single scheme that does migration in a single direction.
> > > Because this is at least second time it made confusion, if you need, maybe I
> > > can try to add a feature for making DAMOS immediately stops after the goal is
> > > satisfied.  Let me know if such new feature can be useful for you.  Cc-ing SK
> > > hynix people (Honggyu and Yunjeong) so that they can correct me if my memory is
> > > broken, or answer if the new feature I described here can be useful for them.
> > > 
> > 
> > Yes, you're absolutely right. Currently, esz(effective size) starts from 0 and 
> > esz gradually increases as `current` approaches `target`.
> > Once `current` reaches `target`,  `esz` then begins to decrease.
> > 
> > However, we observed that even after `current` hits `target`, 
> > migration still continues relatively aggressively - because `esz`  remains high, 
> > and it takes time for it to decrease.
> > 
> > To address this, we previously suggested that initializing `esz`  at `target`
> > (or something suitably large value, rather than 0) and letting it gradually 
> > decrease as `current` gets closer to  `target`.  
> > This would allow for stronger migration when `current` is far form `target`, 
> > and gradually weaken migration as `current` approaches `target`.
> > 
> > Such a feature would be useful for us to experiment with tiered memory system :)
> 
> Thank you for confirming, Yunjeong.  I now agree this is what really need to be
> implemented.  And I agree your suggestion makes sense for the use case.  I want
> to take sufficient time for good design of it, though.  I will share update as
> soon as I get some idea.

I just posted an RFC patch series for this:
https://lore.kernel.org/20260212062314.69961-1-sj@kernel.org


Thanks,
SJ

[...]
