Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018813790B;
	Sun, 10 Aug 2025 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754854352; cv=none; b=pF1eg1exoyJ13vHhZLpDFWjhbX/C0W0GN/zZABVcRggbD4c3v96ZjjwZkJOiFIbBDnhl2bPILi+QGnkFs9wUw4Fd/apYhkIdYVZ3gix9RQ0iX5INVOpUx991Ay82vpwf1ODnA+CPyh4ChLSJwD5Mflo11XqBOjkLdv6Nkagdz6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754854352; c=relaxed/simple;
	bh=7wFxe8f/K+rx3+UiMfHpQ9dhNKDAw8Dtp38fU8iBzeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=smmA8B/Cp0WWLF1K/VPUgrpBHdenE+2+C1w54azcZOFE9TDUFNLOJ4bjpJtWxWsfC0Sfus80dZx70RdIIP7muoeaM4uz8dFr4wKDBrXNm1Y0OqxHM1TPxcejfZuvIm9NIh82sv3EzsckWSTkid/iZQuKxiT74q2ubVRhIZj50mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qph/Chm2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qph/Chm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76474C4CEEB;
	Sun, 10 Aug 2025 19:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754854351;
	bh=7wFxe8f/K+rx3+UiMfHpQ9dhNKDAw8Dtp38fU8iBzeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qph/Chm2kmd4Ejz4y09GSDvWAbiq5rHvkeIdIqzwBUvwqnBN8hhDZTehzmpMDkkpi
	 AkmIEyEFYsqs2qH86ZtTxZUF6TUh462rSmZ56kGYOxJas+Mc7dnZ0q2ePNHZDpJwFC
	 MHP57tC8dewdMofXGcShbSvJuGZLdY33KFKgAtRBE/vgSKCdklPp7FmOt9DwHdVPi3
	 3qMs5sCgLzDmd2LsaeO4Utpt4TeQUobci8HhCsCdLJUlAi4jxdExKRF3crWD3Gck+o
	 uo1JWyNU9hfyOOGe4VP4UanlgAi+VH94RfxWiL3eKTL33JIDEW22SYqCztRCwUdFxA
	 L1aTxCjUKXfhA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3] mm/damon: update expired description of damos_action
Date: Sun, 10 Aug 2025 12:32:29 -0700
Message-Id: <20250810193229.51219-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250805173205.7385-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrew, could you please merge this patch into mm tree?

On Tue,  5 Aug 2025 10:32:05 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue,  5 Aug 2025 21:39:40 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> 
> > Nowadays, damos operation actions support more various operation set.
> > But comments(also, generated documentation) doesn't updated.
> > So, fix the comments with current support status.
> > 
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 

Thanks,
SJ

[...]
