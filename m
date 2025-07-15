Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB47261D;
	Tue, 15 Jul 2025 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605567; cv=none; b=Y/TxrCNj8WU7TFE0ApdSUZGZ1AoHO7LMYap5dl+Vpb0mHIAhwsAWWLwm3+S3zI5WKJFrV4zxIX9Huz+n+HJe9fdECAxN9Zui1m7vVPrP786fTMIj/iX3FBsqf8qx6JAaVoerQaG1Tp1DPyiE45k4ulL6xiQzomDGzxlUN2O2FdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605567; c=relaxed/simple;
	bh=jdBME7xjMinRH46B4BBraFwRQKYs5qKlG5DuwS9Ye8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pSvi/EDh5i/qFAUaPlmhaV5ZqAkMc8f/nmeR5xrYmnMM9itkQ0L4xTljw/LIlsicCCI6gipFMabETdog5v7Pa6ezp13fuFmuBEbZ/oRCRScowrNhnNeqisnYfbVqOpxHe0uLq/g1i8myqWVniZTNVOWaaPvc0FTHglVEg1L1a2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqPzlT2j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqPzlT2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD37C4CEE3;
	Tue, 15 Jul 2025 18:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752605566;
	bh=jdBME7xjMinRH46B4BBraFwRQKYs5qKlG5DuwS9Ye8A=;
	h=From:To:Cc:Subject:Date:From;
	b=sqPzlT2js+YPbMWl8B8dlsydwtcVKB6Kt4dQJtVzR8ky9lXpkh6ZVd4TrHh34RPab
	 LE8rSNbgZVT2HUZlDgu7gNQYBDOfoDOZxJjUyFCUXSyp4iCLk/u5G0JDwxVfFGAYGL
	 Ptt6/kR3ikSnOciDfzRQwvk9vdtT9IgTBi0mBZ+cnJShMElFAoELNHpaGkFimfb7NW
	 rQ9q2nerDgb0MeEwPyFKphTuQo5D3bflEWmLFiIaOt86waxa6Ke68/MvWpetMyIyfJ
	 qNOzhcoNJc6pxG8LoskvNhqTmqRv6Aa19KLh7BAeRbJEVqRRhFTf4Gddx9SIse/84k
	 R1u2BBZQknndQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-unstable 0/2] mm/damon: kernel-doc comments fixup for damon_callback removal
Date: Tue, 15 Jul 2025 11:52:37 -0700
Message-Id: <20250715185239.89152-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch series "mm/damon: remove damon_callback"[1] causes two kernel-doc
comments build warnings[2].  Fix those.

[1] https://lore.kernel.org/20250712195016.151108-1-sj@kernel.org
[2] https://lore.kernel.rog/20250715185549.264260b8@canb.auug.org.au

SeongJae Park (2):
  mm/damon: add kernel-doc comment for damon_operations->cleanup_target
  mm/damon: remove damon_ctx->callback kernel-doc comment

 include/linux/damon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: c6255edeab2199ffde2dafae3c9df042ef4c9ef3
-- 
2.39.5
