Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6628F933
	for <damon@lists.linux.dev>; Tue, 29 Jul 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804712; cv=none; b=We2nx8C348CZhexp0/1nppr2PHV0yYPuIqpgmcJxJYH0Po3HIvmUfyxBYFlBorLHdalZ+MUre/ERQRM2Pyk6R2qlcAGlMzJQ7fUbyuCdudRMRj5+qGlY75dP9i+zFLa8MZNCECm8JZspQidCX4zQ8taxCam7RHAicLHOFf1Htqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804712; c=relaxed/simple;
	bh=no5i8N4XqF2VNil69mGrq36vOP+MLLW27XGJe3Jnfxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2cz5PYmaCdF0vqUbIQm291L/57V6bYr2AlEjIbBUh5E1Itfzxt5571/jQKp9vXYF7VHkeowEiRtt/4eGC+K7105CKzPtv0oY01cVswtbD1ntOGQr/RHKCz9MSiT+O9v5SX28S6BoUtzooB9fRswZRx1d4bi7yZIPNI2Fg/eoSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g361NQMA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g361NQMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94145C4CEF4;
	Tue, 29 Jul 2025 15:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753804711;
	bh=no5i8N4XqF2VNil69mGrq36vOP+MLLW27XGJe3Jnfxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g361NQMAs4PZrWjcf8MDRe94dm2xTN7NbdF7thEN/KXBr+PGlMUQkd8gz9FrEQqka
	 j1T+cmiSzC0qVT39PGoYSQvDF0kbh0QFbtLvnzZnso4Xy34bAIn4138wh7gid1OEAS
	 5LxCygZN34m5GkXvVeVE3ikqF8NmsNyp2C0ZysbpcUrJMkpgCo/1MQXDM3WFKyILdv
	 2yxYjaFGIyBQ1D69frMH0LB/uvkoS5D9AltLNySbXZi6y9bDszWhkbRiRqOcj+dR+b
	 tvUwwfF42/mMZEtQ2vrPMZNFDDrQZtbjpA17/HQXFgRnrCSCCruJ0tbQMQG10fmCxz
	 OisebVlldkzOA==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] docs/mm/damon/design: fix typo
Date: Tue, 29 Jul 2025 08:58:29 -0700
Message-Id: <20250729155829.53913-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729144414.31958-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Jul 2025 23:44:14 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> There are some typo in statistics section of DAMON design docs
> - sz_trtied -> sz_tried

Thank you for finding and fixing this!

> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> While studying about DAMON subsystem, I found some typos in docs.
> This is my first kernel patch. So if there are any mistakes, please let
> me know. I'll try to fix as soon as possible. Thanks for reviewing.

It's my honor to review your first kernel patch.  All look good to me.


Thanks,
SJ

[...]
