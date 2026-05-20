Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4CD3EB7E8
	for <damon@lists.linux.dev>; Wed, 20 May 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286899; cv=none; b=O5zGCPRfFvB/HLONx8aCn6TgcBouRJGlavCFUmRGQ+U9vi0hvrenR8aWL2uqFTf+f/RIQoc0tqWptqvGBfjPlH3eS5melv804LYArMwi2y8VXjSBuDuKm4/lcTZmD2aaRyvGRBnuLXVUEtPfqOX2CxTF6/Z/Jz1zecTfF+0LEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286899; c=relaxed/simple;
	bh=f62dx50vWRMqzsUPSu1AbQMG4xyq/p3PkdEM1yxW4uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFHHeYZa2BYpZOQOUrGB/dfLy8JVKgdeFaZon4P8haHP5s9gfk04tJNZdpzIa2mA8UddJAonfh+qJbaj93Gs67Qdc7/S/wITEgOfJr6GxTyGU19Ke6x21/6e3Mw86UtY6GzmhhyNmDMbPGB29tuIwoTT0/UbDXyI5P+Qa3Uh55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HatsCjRh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HatsCjRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107D21F000E9;
	Wed, 20 May 2026 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779286898;
	bh=ZVuywxhqrZVm9qQWhPHYg5EKWnIS3yU0YuG2AOVzvcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HatsCjRhnXzcUv/dC6Q4+MIOmyLvOykRBTaCG5YLYKtw6cP6hbt4hCn4AooNYqyu/
	 wp+NiWwsE89OwPz6DzRLZDEFUXxP8g2Fm2mcFexcE3WpEOaV+p37KDSV1aw72DpqtZ
	 B0CaCPxVt/aq70p08xsoiPoo49X4T+EV2PTitzcwBhUSvFxtffw/BU++VNTvYPiHwz
	 tSsgBym3nl4JJ3MsRR8Y4FNSmiYCrRSHJ0QWHTLrxri8+knvi4SHKiHpW4EmXUW9s3
	 ejRxwA4JrLxuVqcV1YMMsBgsKsWPz9fmN9mHbqFF1kcaNcu+mFMS1QxoXh2pN7+4LM
	 /ZY0Sj0UE1/KA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 13/14] selftests/damon/sysfs.sh: test addr_unit file existence
Date: Wed, 20 May 2026 07:20:51 -0700
Message-ID: <20260520142051.170627-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520140819.169963-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 May 2026 07:08:17 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 20 May 2026 06:41:56 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] The newly added test for the `addr_unit` sysfs file incorrectly passes 'exit' instead of 'exist' to `ensure_file()`, causing the test check to be silently skipped.
> > --
> > 
> > commit a9bc6162fe06c0405081aeb68c3f5e9a54287e20
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > selftests/damon/sysfs.sh: test addr_unit file existence
> > 
> > This commit adds a test to verify the existence of the addr_unit sysfs
> > file in the DAMON selftests.
> > 
> > > diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
> > > index b3418214ed358..1e10881afabb6 100755
> > > --- a/tools/testing/selftests/damon/sysfs.sh
> > > +++ b/tools/testing/selftests/damon/sysfs.sh
> > > @@ -365,6 +365,7 @@ test_context()
> > >  	ensure_dir "$context_dir" "exist"
> > >  	ensure_file "$context_dir/avail_operations" "exit" 400
> > >  	ensure_file "$context_dir/operations" "exist" 600
> > > +	ensure_file "$context_dir/addr_unit" "exit" 600
> > 
> > [Severity: Medium]
> > Is "exit" a typo for "exist" in this new test?
> > 
> > If ensure_file() expects "exist" or "not_exist" as its second argument,
> > passing "exit" might cause the function to return immediately without
> > performing any file existence or permission checks, which would silently
> > skip the intended test coverage.
> 
> Good catch.  The ensure_file() expects "not_exist" or anything else for the
> second argument, so this test is working as intended.

Sashiko is correct.  The test was doing nothing.

> But definitely "exit" is
> a typo.  I will fix this in the next revision.

Anyway will be fixed in the next revision.


Thnks,
SJ

[...]
