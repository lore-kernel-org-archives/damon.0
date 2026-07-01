Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459A224FA;
	Wed,  1 Jul 2026 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782868103; cv=none; b=nEmXAhtwe2VN0lmcy/Go2CHp9jsHZ5KodVQGla/A2AvQ8RI47g2ZZAVrT7PNzrS+wNtsbgCYIN4qwKzkRiFzCepqM2QDXOWteGa58tu/NZMZQwO/ShSgfwfFH1u59niYQtzCDP6NuwxF3or25gabzfv/KNUkBGr0q74TW7GJLpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782868103; c=relaxed/simple;
	bh=WvY9S5BJ5IwTsYKxkJn04SXO0o3zQPAlREvubiASm6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OobkfZFqjIeUmn5TQ/aHjkuofT6oTHjYHId6T4D1dFndDnVD4PM25hKcgwd4IHB0QAg71xmvh2EfYVtFb0tkRNQx045vkqRwUMJyWGgpL5AtQWn1gC3SL8MUbtY3IZ2PxTCghSfyLcbt8dERvm/cm7a1aadzzw+Kts31tEOXmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ6m7d/I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ6m7d/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EA91F000E9;
	Wed,  1 Jul 2026 01:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782868101;
	bh=l7NtdNId2yZYedn04+XbzeafC8xkayzTBJlg6/vczaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bQ6m7d/IypMudNG0ClR4/F6d2wvPfADidg9ROFa4/xfs8MsRnHrTX6sEenAXhAVJm
	 Mr8GHAUMspE2LoggB0WZ+oAkU1a5FLdD8tZF/C1W79KzChQnfnj9u9NUajgwYQP4NO
	 ZwDHC4FN+Ix8NNhmIOZ31ux9IAUc1D18FOTwJOiTMBkcnsnWhIoXzwSGWoTDPcPzGh
	 5lGL8/Cl5jfp840rUbVGapPokme8JYFOglKC09gKFMHfZbaOKh8OulA1PkyayfAP+s
	 xaZTZvX4KlEVuciw+z3ywgF4ld1H4C1xU2VAqrAR5QkQEvL2lVogkmcBScg0ZWUNdJ
	 CGyOY0Vgw3e6Q==
From: SJ Park <sj@kernel.org>
To: Igor Putko <igorpetindev@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: check address space stability before VMA traversal
Date: Tue, 30 Jun 2026 18:08:13 -0700
Message-ID: <20260701010814.96836-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630152558.24063-1-igorpetindev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 18:25:58 +0300 Igor Putko <igorpetindev@gmail.com> wrote:

> In __damon_va_three_regions(), the VMA tree is traversed without
> checking if the address space is stable. If the OOM reaper runs
> concurrently, it may mark the mm as MMF_UNSTABLE and leave empty
> markers in the maple tree.

I initially thought this is correct, but...  Hasn't the series starting from
commit bed76bec3111 ("mm: relocate the page table ceiling and floor
definitions") fixed the issue?


Thanks,
SJ

[...]
