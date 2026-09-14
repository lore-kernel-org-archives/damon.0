Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098BB494827
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400191; cv=none; b=Pd7qZLzpPJ8tjKgvXeIDgcqPUqooMpF4etrufEfByNMxH0QUdjxbMPoIjWVN8Aam08vixFRbafTdURf1KL5yJP0odJnqHgKASN3GWc9xNQM6LDu+TIDQ4pfnYO6chhiOOUI0GCSmt/oDvJPLKw1SZEGj2BsaRejaKU4t947pmJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400191; c=relaxed/simple;
	bh=u1jGnxZrL34jcWfWXgKpMWjRKWtCFhMxGheVNVYCqWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CDnABzys2v5HlIM0IXA/S9tZXbWvR9XTILz7675E1h5z6rrfCFUb2ZEfiQjIYmba/+5SAHLxY6x4Bjrz3Hj6/aM/xFBeOBt0Lcl93Vxpru0gNJY4aHF6kNnRYqDAqYTiBeYnVb0sU13pcTiP+GEdxLbGZetMLmbV5kKJ67HLDqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5vcchEG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5vcchEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8993E1F0089A;
	Mon, 14 Sep 2026 15:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789400189;
	bh=oUeQDZ0MYrH0ffZHNyQnZeyLgZxgY9q5VGDBTLwALM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5vcchEGuGVlBvQxIJClJ6dfGclDaVHmSSCVlj9GhFMcjhfjNS9fEqdc5y24QEGPT
	 BrGGDQju0eexFir6c80AaZd0qG4R1Rp4B2oCNlV2Pp8ZHKTViE9rWqm+eXKwp5Q3cu
	 ZPgOY1V/FWew4HQP1gCwGMlLcPMgdTqwDCxymC8fETZwiNhCc/mXMC4qjlJ5tDPwZt
	 1JwNsjKzmTD8CC9fL3jmw0N4P7wAsNkB9f7dQgawttixnaUJ1kV4/gIRD7PgKblRXy
	 s14p6zPaHLBJAOJJFq5cCx4L/o+7px7SoeWhBS9KNJd5h00BIfr2ZGKmpFUbVNqxMb
	 5Qf1Idi8Y7dWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] mm/damon/core-kunit: extend
 damos_commit_filter_for() for wrong input
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914142327.92510-8-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
 <20260914142327.92510-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:36:29 +0000
Message-Id: <20260914153629.8993E1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_commit_filter_for() supposes damos_commit_filter() to always
> succeed with given inputs.  damos_commit_filter() could return an error
> for invalid inputs.  Existing callers always pass only valid inputs, but
> they may pass invalid inputs in future, for test purposes.  Extend the
> function to be able to be used for wrong inputs-caused error testing.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914142327.9251=
0-1-sj@kernel.org?part=3D7

