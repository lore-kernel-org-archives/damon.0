Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2889F2F28FF
	for <damon@lists.linux.dev>; Thu, 16 Jul 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210082; cv=none; b=EyqFGjIrPjqecHOQM/kwurOXZjcSyNH+0yHvKaTOkXXQL1TCYo+ZxHbFBaG+/cCbUNhu+09fdgsBI1tpr3mcPhjGiRgJ1zMY8aWIzf5GLUvTOGRlUhD/o4osYSgZKleP/W0IoK+lr6oF6/n+iR9gzQZ+iv/TBX3f/lRBkBIytOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210082; c=relaxed/simple;
	bh=xbXWt+RTHsLPEvugFnq9+Bno9nBggWeeaPmAY8riu4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y27sP9LdwecxU1ZpOP5LHGI2q3NNRugO8tF92a2vscoxRIbkRvAf0eKvDnRTxF7VoipaJeK06ljl83I2XgiAyzEA1sMYUzn7374qp9djM7D4vTlZKu36jHvpiqoGzkgk4YRRwj6LTamDkLMYojZsoN9LE61PHhBA4R1DSdUvse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROn1OsP4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROn1OsP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2101F000E9;
	Thu, 16 Jul 2026 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784210080;
	bh=+Irz95G1lM/HF+OWbwi2S82U6C5Yrl98ngENc7Q/VU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ROn1OsP4Gw9erYrgPy++5eJ1IYm8t7d3aTrjX2+NrMsKNM2z2KOYgSwkoo8R/x9kf
	 WhQYLNDc7mZlrkE6sh7TsWs+aE1qVLh1takK9dX5xRxyXm1sxFNh4mZnXxvSdQ/5Vz
	 IIGN/zPhhdy7Gz/FP+Vahl02yMtT1FNm7vR8CYHBINkmrI9k7Lh1uFXib9HyqGpfdW
	 ckuegMf4+HWU4fCgGT4Ivf7oJktdtGVSdBnQ9EneXi/kecNczmQK8VfGDReeCDdUuo
	 5iLiHP5t0WEBp7o0m+hWknT+PJiOKHpkdGI38fnjGCS2uGwW4DkJk/VWF83tPrGNNm
	 2LeyqtzS46Hvw==
From: SJ Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] samples/damon/prcl: add module parameter description for target_pid
Date: Thu, 16 Jul 2026 06:54:37 -0700
Message-ID: <20260716135438.101815-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260716091444.284702-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Enze,


Thank you for this patch!

On Thu, 16 Jul 2026 17:14:44 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Document 'target_pid' via MODULE_PARM_DESC so its meaning is visible
> through kernel command line usage and sysfs interface.

But...  It is a static module.  Is there a way to read this documentation from
the user space?  If there is no such a way, I don't really think this change is
needed.  If we want to document this, we could use comments.

I show 'enabled' parameter has MODULE_PARM_DESC().  If the inconsistency is a
problem, I think it might be better to consistently remove MODULE_PARM_DESC().
It may also be beneficial to comment why we don't have MODULE_PARM_DESC()s on
the module.  What do you think?


Thanks,
SJ

[...]
