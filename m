Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB37331A7B;
	Fri, 12 Jun 2026 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276733; cv=none; b=LKyI638Ktt4nU7IX0MNkO/V+SPce/DoNbF2uERIvGf4aCuSGEcUT0hXH+XbxGVj1MrNTc5x+qgGnj53jd9MtGGgrFOBUSagmmaZOlfGNunmlEoas8LhVQ0DTMwynN6y9Hpm+FG1rtsZq/Ba/0g6DmI8EgyyoOuTbztFpoppDsKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276733; c=relaxed/simple;
	bh=lFWyF3MUzH5yXMZ2h7JK+QO9d4tUAhsFCCbNi/USkw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRO1i6rzm2haxQaiQhx7Bq7QRG35WpmnHkhCtiEroc07A0hHB7c7r2FVwVzPUx6hiDAT2v5nkbSiEFOBc4p/yjUm41E49r+cHPE52TbDAslU7wCKb94Veg7zy54fHfFBRGTnm8wko3h3ckBkPncnAoteLyXgY3QB+ebPg8gjr5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3Bjk6Xc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3Bjk6Xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5280F1F000E9;
	Fri, 12 Jun 2026 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781276732;
	bh=rdqySyIK765/5XAxZ3yDsSGj9IMPdHvPQEL66jI/4x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O3Bjk6XcazGCZB0etMaC1lMSb67pMC2hUv0CHNXDxg4+idcDpgHjuAF8mdmL/lTrq
	 420ll8cJEWP4T0UPWRG1XU7ZdLkWXksNNtFVokjx3POw5pHoVO2T8ckSq5zzhTT6EY
	 jdsIXhNLCXNP35lnsoeJq+GbObjtmWC4/qj7YNXuixuubGCM1T+/5AsOPO/JOI26Rx
	 CYR8LrWQbWwiklmjT2pga4kr440UTUocQISzMyAiEY7BO1m6iLVQg4nTQfZjL3kpeW
	 ZqQ0hO/QL3SjtG22nS2LLwpWObTA/VVup0FZ7ir4DF+OZ7oKb4T1IGprjViB2A2SCZ
	 e3QTw3/qyIuFA==
From: SeongJae Park <sj@kernel.org>
To: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/damon: add KUnit test for walk_control_obsolete behavior
Date: Fri, 12 Jun 2026 08:05:23 -0700
Message-ID: <20260612150524.95770-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612062337.2459-1-saileshnandanavanam@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Sailesh,


Thank you for this patch!

From next time, please send a new version of a patch as a new thread, not as a
reply to the previous version.

For the subject, please use mm/damon/tests/core-kunit: as the prefix.

On Fri, 12 Jun 2026 11:53:37 +0530 Sailesh Nandanavanam <saileshnandanavanam@gmail.com> wrote:

> Add a KUnit test to verify that damos_walk() rejects
> new requests when walk_control_obsolete is set.
> 
> Commit 33c3f6c2b48c ("mm/damon/core: fix damos_walk() vs
> kdamond_fn() exit race") introduced walk_control_obsolete
> to prevent a race condition where new requests could be
> registered during kdamond shutdown and never handled.
> 
> This test simulates the shutdown condition by setting
> walk_control_obsolete and verifies that damos_walk()
> returns -ECANCELED immediately.
> 
> This validates the invariant introduced by the fix and
> helps prevent regressions.
> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>

Other than the subject prefix, all looks good.

Reviewed-by: SeongJae Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree after modifying the subject prefix
as I suggested, assuming you don't mind.  If you do mind that change, please
let me know.

We are now quite close to next merge window.  We (mm community) want
to focus on making mm.git more stabilized and therefore ready for the next
merge window, rather than adding more changes that are not really urgent.  I
understand this patch is not really urgent.  Hence, Andrew might not add this
patch until next -rc1 release.  In the case, I will request adding this to
mm.git after next -rc1 release.  So, no action from your side is needed for
now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
