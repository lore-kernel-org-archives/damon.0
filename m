Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC8B51CF54;
	Thu, 15 Oct 2026 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073110; cv=none; b=AdKovjFanHzA/X253Iv2CMT3xSnGres4cVhFSfqSALCHG/16Msxd1VNwg/bWnXivp6iBhdX6zV/Bk3mrvw0QG0EgQRBTI9tZQ04VF1Ss8hdSqWjfFvNu1Xc3lsMXu48IWFg4k6805VBOEqPUX2MLBOn4iwJossFZaUHvvsqU2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073110; c=relaxed/simple;
	bh=+unhxejwLGoCorOIr4ni9FmFAe8EO42zECrx8uh0Ny4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkwwziWA2sX3E6zwmOnjZSZ95IoHCtA9jhbfUHa14fpyRC/oBT98BcNmU9LLxsbVfpv2kaJx5vT9niqM2A762FUK0KUT/v0fVlHElxVCyQsnNMj4cBSvgqo4jFRbFXcuQ7JujF7sf87/brS4NCArhs3QX8kJhRIgUbLAzdRL9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tnslj58V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tnslj58V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE891F000C6;
	Thu, 15 Oct 2026 14:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792073109;
	bh=5ocp4Et+sK/z58kpgz7L+Txb0eSLyo+tHlzKReRnPCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tnslj58VcWVpVH2J5Em3kGZqb2Lv4pzwZPtldGD6fzcLiFwsjPKtWdAsQZkqfue0H
	 q00IUB0TkvRYKIgWrzOBh40ZHTyE+yumCC83Kh3a4i23PUYwQmkyu8sKarYwII/AUk
	 Wj0yW11JgnqZUMdpMcycBUwI5wglVWWoPVhckHTzt2zx5zNbFmw0QzlNehMyhnKHk3
	 vOiFHoRdFXUX4NJ2FmDrVjLlWrEoiAYXF+sk2KbRbW2sqHj0q0jFtz2K/lN9Lh6tCw
	 5atdSz442mcHmcBok5QP2DHIuOkz8reEfp/1+cIArP7LybmAgo0VsSmSZRAblYCi7g
	 zCWLXW/5CPIUQ==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] DAMON sysfs: failed update clears tried_regions snapshot
Date: Thu, 15 Oct 2026 07:05:01 -0700
Message-ID: <20261015140502.87975-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANOyQmHo94dwHVMWeUfQsks0b30uZT0wuV8mDQ9MjB-HL0yVnA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Avelin,

On Thu, 15 Oct 2026 07:22:38 -0400 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi,
> 
> On mm-new commit ad9f2d463666, requesting
> update_schemes_tried_regions after stopping a kdamond returns
> -ECANCELED and clears the previous tried_regions snapshot.  The final
> result collected before "off" is then lost.

Could you further share your use case that this behavior becomes a real
problem?  Also, have you tried bisecting this to find from when this behavior
was introduced?  If so, could you share the commit that introduced this
behavior?


THanks,
SJ

[...]
