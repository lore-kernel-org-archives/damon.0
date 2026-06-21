Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258922E3F0
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782074269; cv=none; b=djpOAMVRcUDhLw9e9QtyViWBwHGPa4AenhKKTCAx154tFXdVoKk6sl/W6btXU650eHpGJKhf6PhCQ475w5jjWelj6qbNXRmOXikthrHB6OIjhjLjKLQBsQF7VSQldjdmbKp9Kd280Hxax3m/UGc+CnkUHgfOJ51jG7SbHxFWMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782074269; c=relaxed/simple;
	bh=xo+To1CsSCuo8muNgg7joosXHG/hqBbYhGTdI4u3m/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeogA7KCUVx43Fuv+gIszKtbMeNFAVg8JMR/jT7l7a1htqJDcRCGkbVhXP+ocHkKGdJsGRQZA5+dF2u/jrzEAbQvjopCkJpY8STgKSB2N9ucJtklcjQvYnfw86SNpYpxTUImsnQpgeqRXa9BuIqjwZwCSaJd4amXLB7jB9kddo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTyKCqtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTyKCqtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4CD1F000E9;
	Sun, 21 Jun 2026 20:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782074268;
	bh=NaS9DLQkwCKL+4ziCoMg99MpWASp7N/YT0hoRAbfT5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mTyKCqtTSEEFIkN2uEhrB2k3t+snvNTqt01FlOTBJb+HyWKSbZfWPdT5Tmn6FMNGo
	 tiN9PP00JStodxB8nvvVJpKLGFIweOsvjdELc+uNYQZl0LTmCBotpYR0yRpxUJbzfK
	 zKl23tUWH56j+caAJDzrjk6Bl/7SOZpV5zgNBgIg2Sx1ossYHkfAseWCA586eBLNGJ
	 9QwJD/SiaXbeQIVQOh1U0mRy1lgp+MV2IAGcpBMB+3nh76UEKNhUOHh1xmo1kwpCH2
	 oLKIP5gHeG6GphW/ot/cCdjL1OjwJgPFksRZhXeZwT0pgHwXy0MHwFZRdlnOqXv+Uv
	 Xz4CWvSE+pR7A==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 12/17] mm/damon/core: remove nr_accesses_bp setups and updates
Date: Sun, 21 Jun 2026 13:37:33 -0700
Message-ID: <20260621203734.10843-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621181005.CBCD11F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 21 Jun 2026 18:10:05 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] 32-bit integer overflow in mult_frac() calculation for left_window_bp.

Known low priority issue.  Not a blocker of this patch.

> 
> Pre-existing issues:
> - [High] Region merge operations do not size-weight average the last_nr_accesses field, leading to inaccurate pseudo moving sum calculations.

I will separately work on this.


Thanks,
SJ

[...]
