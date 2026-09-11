Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC626CE2C
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089350; cv=none; b=d624jh4PX4KBTrOkZjJJn2nmng8TNY+SXlScZfvz/wHTAnxCgUuLhjbej4TcIMnuj3ha/RH3SSo9bxfjeaZK6fTP6jbZROP2w+8sY9NSOHRPyigzUqOApQaCMUszmaFjd7WtI62Z27xhOWOMUVaCkaNrRPpZhZ+Sc2+PRXrnVb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089350; c=relaxed/simple;
	bh=HZCprVPTSEO5Z59CZuUZ19SavfJ440qpuDcZK2tU8LY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hrC+JSt/woFDVNmFxuaxntiB/ErjeuIWJzkzccvHJVsTQfXctjLGTnydWieJPdGEeWWt51zq/7XFq8qo9aKGAuzX5T2fCvJYieBqNfLAJCCs9CS4Uw1W0hWUhyWI9HvoQxbVYvAxeyZPij5t/anD7O1lFlhLTqV/kRrbVH4Ci9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUj9w/bq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUj9w/bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954F21F000FF;
	Fri, 11 Sep 2026 01:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089349;
	bh=HZCprVPTSEO5Z59CZuUZ19SavfJ440qpuDcZK2tU8LY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KUj9w/bqKHN1fFIWtJm+/bKeR5EEnMF2VTpLAJwtZemnWZgniGcdYHJTZIlU35H3J
	 myX7/wv1IRlOxXZPPEhecu0DPRYpUQwW6jUczZzKzecmYLIdjZiHbsxUxWsuEhnm8m
	 3Siai4e4TyYjYI1H271MX7JxvjkV+H9mAEKtcRoEL0EWksReCqCQG/BhB1zMAzYWFZ
	 K5et1e9Q5nc5fHbikSzIM4c4j18eQpHmRsfMAlINNZNSzPi9VoLpXZmrW8+A8kIDx5
	 o60OKAhs7T+w4u2DeEQnuFBbVM0aXbvFDNg+4M8eP10Tx7YbVEBufmjI+h/6fk8sRE
	 HF6rAEZBj2Ytg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 6/7] Docs/mm/damon/design: update for
 probe_hits_wsum DAMOS core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911011330.93678-7-sj@kernel.org>
References: <20260911011330.93678-1-sj@kernel.org>
 <20260911011330.93678-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 01:15:49 +0000
Message-Id: <20260911011549.954F21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added probe hits weighted sum
> based DAMOS core filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911011330.9367=
8-1-sj@kernel.org?part=3D6

