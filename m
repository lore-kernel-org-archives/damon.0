Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801D6F073
	for <damon@lists.linux.dev>; Sat, 17 May 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747497397; cv=none; b=UjKzLCk4/G9/Veyz48uCCuTLbVsUZoKtacRzo3dF/S0ycHGv/Vde+V2s0ucJGQENfFnszN+4JaVYJkOjNnjuCTrLWPL9KA+XMdIKrSQHdVprnWI9Qy/6w9PlQT61Wp/oXAeGkkKJycz5g0DHnJwHVnKBeRpImaBk4IdtxnFjxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747497397; c=relaxed/simple;
	bh=M8+rZ3NXX2ZFZh1RN832EGibDnoiZDEzaZLFMB2NZuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sqxW/wKJ3SkllhaZ+8c/4K7fbjxYFA75OZ9QJtnwsei5Fuubpv00Gf5+8ROXrlpd9GR7+WRO+Jg3fphlKJm5thqH86kH49PQjO8Pn/LKu+KRzbQSuZUpgxVFWdak6QiiYhPD9CanUV8sKxYJtnJHpSVE9HN4aIKGQS8MBDqjsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Csa8MwEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Csa8MwEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD747C4CEE3;
	Sat, 17 May 2025 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747497397;
	bh=M8+rZ3NXX2ZFZh1RN832EGibDnoiZDEzaZLFMB2NZuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Csa8MwEFaic9IVgL0owHD2cYFCYaWnmdqWiH8kqDGQNXjsdcKfc5hQIc4tjc6oCaW
	 kcfCt96pW2vhxCrNJLh5pv0E55wI5wOvgh04u85WPYUPx4VvcfiXZlBFp/vx5l8Rt2
	 HeGhMaFnEnbdCgaq9U0bvRgnT2w6F7fw7nxYYTEx8HNq9yBINXCX52wukNlyrS90Zy
	 5Gv+XUAzOFlcKdE3Ye0MwEa+pSwlHT0ZD0TrQqMCUoddkq1guzcTx3wE/JldWRodQV
	 iW4RhJ/robHJQbnlR2huvN5JE3jo3QDB2ZgczmMHiAg5POaurTj/tlVXwl+WwcmmTx
	 L+Zju82o9ZA7g==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] mm/damon/core: avoid destroyed target reference from DAMOS quota
Date: Sat, 17 May 2025 08:56:33 -0700
Message-Id: <20250517155633.35139-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250517141852.142802-1-akinobu.mita@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 17 May 2025 23:18:52 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> When the number of the monitoring targets in running contexts is reduced,
> there may be DAMOS quotas referencing the targets that will be destroyed.
> 
> Applying the scheme action for such DAMOS scheme will be skipped forever
> looking for the starting part of the region for the destroyed monitoring
> target.

Nice catch!

> 
> To fix this issue, when the monitoring target is destroyed, reset the
> starting part for all DAMOS quotas that reference the target.
> 

I think this deserves below Fixes: tag?

Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")

For a clarification.  The worst scenario consequence of this issue is DAMOS
unexpectedly doing less or zero works under certain setups.  No horrible
problems such as a use after free will happen, though, since quota handling
code references quota.charge_target_from, but does not de-reference it.

So I don't think this deserves Cc-ing stable@, but I'll let stable@ maintainers
decide, as usual.

> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: SeongJae Park <sj@kernel.org>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
