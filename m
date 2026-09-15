Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B564BEE38
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438818; cv=none; b=sXBOo7ZD0iDsCAWrq4fPyQ2Xzisz4HWHZoGxdYmetBAEsdCJQsgs56zARNd0S4VJQV37zeUNJeaQAUJt3mstol+BzOHlF/FTtPXA9m18WduKRqlKalmD775aVi8YNqEKYWHNtFfK4K+cwCInc45UkwErALeYKIkbxBo1kF6i+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438818; c=relaxed/simple;
	bh=by7BuJweVbsTXAOwH9oK6A78Eh05DJ39uZAf12RMcMM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qnkvEUBEYVwMhdi5PF6Pz5wkoMHMr+0PMtpIv66DT4NjX90eh7w6bRJLiGyoeZXF3HXeOEshbPb23FH5au+Pf2FOj2dp4JCxbAUNScdXATvQYAvFi1aF/crvaNW/upRqfsqJ1FlLYzZ+jd2X3KJntJFmtDWBn0mQgr/W+P5aYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3cUC8kt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3cUC8kt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156321F000FF;
	Tue, 15 Sep 2026 02:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438817;
	bh=/IoCpo2QeyRlykwQZWtK/c6iGbkXTymEaxzI6Im6Wes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g3cUC8ktgbWEq1B74CCAcIl7CBSmwVrSMn6xgtDF2lEFk5rEYrzcMzjDbgEUFXRIK
	 MObJLDoyo5P0ya53PdYQUHdYkIPNWPQOGwPPQ23b2eyM8KeviTU6FIkLKYgSE6OyPy
	 q4aw6Xsy0oUIFumXvUXyEpn4+jspK+hQCukfmQdtYw2FK7yMlKY5WFVmNmA25+PdfI
	 Kd1oeO3VI3ZlYcka8yK2U8SCmpi8OqfqFAoBphRVFqm6pJsMeBr+8OYAKeTpFIjQu0
	 k0jRu0pvaTsl9mPDW7B5htP0lWgZAAUVJERGjextV5+sxhSQKuin8dydIRupoKoCja
	 jYYv+w2jXbTQA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/8] mm/damon/core: commit hugepage_size type
 damon filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915020929.102953-3-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
 <20260915020929.102953-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 02:20:16 +0000
Message-Id: <20260915022017.156321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend data attribute probe filters commit logic for the new
> hugepage_size filter type.  Since it needs to carry the size range of
> the hugepage, update the logic to update the size range fields of the
> commit destination filter struct.  While doing that, validate the given
> range and propagate an error if it is invalid.  Add the error handling
> in the callers, too.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915020929.1029=
53-1-sj@kernel.org?part=3D2

