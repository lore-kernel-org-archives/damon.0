Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B74756CA;
	Fri, 25 Sep 2026 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326353; cv=none; b=nto0S6ZSP8Pj6nFZHhQRgjm2VFFW+HRbJIABuWKPqhzfwqc/IhkV8dIlEXcKan9L8gdHL4/LwxgK/MXWyCfhlduz7DhGBmNsD8E+Ke21JZo5KGiFRpdWd+fygip0bxgbr9X8FpDOoKSVVBwv2c6VGejBOjulo40d9N06kYJDenA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326353; c=relaxed/simple;
	bh=UGGLqMF2euC6/YfMnuNXgfrFb3MaDKQkmfbFFxxCX4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyYP8DGFfJrRQMkeZdN4JKrg4X/7mjSUO2lzxt+qw7tPMsAVf2tgYCJO9SvPK0Pc5zeq3Gw5de9t9iLQUzr7Rk2AdYg9cHpaBNtvMI46LHBwIU+3HVym8Zr1lKe+5yxqFr25TSRDyjWr93BEfbbbAdaANUgSkRptNCfTWsom8ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwDAiGFw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwDAiGFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10321F000FF;
	Fri, 25 Sep 2026 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790326347;
	bh=f4ptkTNJohdeKTdLCn1SvyIDDWNyPxqWpX2yO7CKxHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fwDAiGFwokb5eUjOgjzBenqA3PusyO+kfYTFnmgXTYyzx+YeYa1AV6UU+Wio2StcL
	 0hiiIiaGOQ4qbX18OEatoqlJG7Bm2UTreJdkzdctaXobnKfCl6SEcmJ45IIP6SaQrM
	 kfP3xHUgk1Ud2nihXyK/02zWfh69tdVCaG/VuEG6R0+TD5w/GA1u6Lz0Qq68nYWmz2
	 ANkRSehxqkSu7IcCaeHJDU0e+ytyM8NClrAFKRhlJOr200POns9tfLVaIbGkBBH1y2
	 RqbJnbgjdsr8Xe2aTcJNHTw+9+lM/dzBgxihE1WqWd/LXEJ6FlgGZZLHXBMk6j4Sil
	 SoCxMPcooXcuw==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm/damon: preserve quota state when constructing schemes
Date: Fri, 25 Sep 2026 01:52:20 -0700
Message-ID: <20260925085221.47343-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924201615.4478-1-kmehltretter@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Sep 2026 22:16:12 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> damon_commit_ctx() first commits the running context's parameters to a
> temporary context for validating proposed updates. Constructing the
> temporary schemes clears the running schemes' quota state because
> damon_new_scheme() initializes the quota passed as a parameter before
> copying it to the new scheme. Even an update later rejected with -EINVAL
> loses the running quota state.
> 
> Initialize the new scheme's copy instead, and add KUnit tests for the
> constructor and for accepted and rejected context updates.

Looks good to me.  Thank you for this series, Karl.

This series is applied to damon/next [1] tree, with an addition of user impact
detail on patch 1.  If there is no more change requests and this series is not
added to mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew
Morton) to pick this.  So, no action from your side is needed for now.  If it
seems I also forgot doing that or you cannot wait for my action, please feel
free to ping me or Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ
