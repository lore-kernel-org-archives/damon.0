Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240337A4B9
	for <damon@lists.linux.dev>; Fri, 22 May 2026 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779480568; cv=none; b=TQJIbJNMOXu1hMAw/cCDFpx4BBFrqqTuYQKYDq97CnCbtNR9L8IpOdFtQy5Kq1qrojvrPgpkZCsyGLVfrv3gmS6DanGGCil5VdNk/UU/RX0SspKmU9hIVqG3f4n7eAQjYvONG61v511OWyPhN54ayjjWO2CWJcF1wSWx9mUUb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779480568; c=relaxed/simple;
	bh=Ek2UPKrzQ90AReyisilyq7N4//rdIgjbwKt3rdRE3Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHVZ3sCA0s0s0uTtJpSFXRDu0qD9fgsnYPgaWAyNmMz8sdezVktufsQkOcnO2pCNBLcFv+XH1E7DgO4G7akUuckhDm2t68cPQWNZ2pmsMJlhod1ko1aTUExTRYqUr3pjuJPaHObzptQXQ0Ff0kE9phB7uk46P2uJ9DBjnBQiba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdVp20G3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdVp20G3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7680A1F000E9;
	Fri, 22 May 2026 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779480566;
	bh=lY5nJ8+rxDqxv4eD5hgnbmqhkYJIexDV7KKloGpXRzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LdVp20G3bheUj4WZGd1S0Eq9HRnnB4Z3QJ4d0agRJ/pqi/WQG93xJGIb8Bfdf1YxG
	 oeN8hbZNWdKyjrDRKp10Ezd8daJsw9LX8Nv0i2CCyv+zrJwY6YX8eIkafRr2XsraDU
	 PY6ETiyWOBANFr/eAtycOY9HLZmaAAp/Xp+ffGTPXAXXlQdONjsW6YN07ZSI0LkfNK
	 bUf3GPLIMoJUwYs1Kw02iE83B+i2fvhFGj+nTARr7OohF1iEVNTNYxVfCzhEfW7UTu
	 bfz2bb7QbosVTA5rr8HtdneyrdJjMQmOLsoHVwdaZPyBjfCiEt70EIcgByPqbG6ky5
	 1sqxNDAXjJm6g==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 01/14] mm/damon/core: safely handle no region case in damon_set_regions()
Date: Fri, 22 May 2026 13:09:23 -0700
Message-ID: <20260522200924.3198-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522161818.D9D5B1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 May 2026 16:18:18 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] ALIGN() macro on a user-provided 'end' address can overflow, resulting in a region with start > end.

No blocker of this issue.  Answered [1] before.

[1] https://lore.kernel.org/20260521060523.80684-1-sj@kernel.org


Thanks,
SJ

[...]
