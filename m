Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055423EAB0
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013121; cv=none; b=jT4d6iQA6q1mEAWDEnKBI1Jp0m2ZUNhKxZcLedUYcZfk33cvdXJ/kX8A/JxPPDhx/2m/DFdap+GvtEBebzUW66zDdzCNfg4i37+pR0MHJfsuI/m0ikB1BrE6xV4XBHoaLg0IC53eK4TbukR4bmRdG4II2HgLFhCN6YN+h4o4XRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013121; c=relaxed/simple;
	bh=81ygyM5LfEYEwZYPVtd/IKId+bjShRx6aA+N/Mjbp74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T3fcCPUTfAAorw1R0z0N5scEZ4qOAU45tn+e7grD50zqK0u0czApigf/swLWqiM4UqBodcqQ0hw69zp2g/WonXTlYknZyvHT0oeIfNBk0AYL92LD2Fybs7m/jDIxm5m8wQ+YSm12b1br1fdsUzMf8MyC0MoPPv4i6pSpEObRwos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StA/olSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StA/olSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2C51F000FF;
	Thu, 10 Sep 2026 04:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013120;
	bh=81ygyM5LfEYEwZYPVtd/IKId+bjShRx6aA+N/Mjbp74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=StA/olSHRUWWSB84x16V5ffEWqkiiK6cI57iYkKlVC7MppqkMwONewDoJN39oqW2G
	 wqgibtzjvIsBmDu2E0Xy3/QaOlEJX15nInGO55sP9TqIGA/3BlU9Odk8n8/lrqYpky
	 iqSwr4USzVnr1JFeDuj2eW0ciePDxrTQP9ZLPziJ2fuDTGR28IkdJBd4o/y8jyxNRR
	 UTboZj3mi7qPShsjbqWMW58NrsVEUw164QRpohnGe+iJ/8r3+igI0pdmKmwT8h7x8B
	 szP5izBI6Vae1wbjDW7DTOdRcx1Fq+cfmrYIfAxjQkXhbIInity3JIvZemoBDtZP3u
	 XuWHIzU4QtNog==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 6/7] Docs/mm/damon/design: update for
 probe_hits_wsum DAMOS core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910040319.147037-7-sj@kernel.org>
References: <20260910040319.147037-1-sj@kernel.org>
 <20260910040319.147037-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:05:19 +0000
Message-Id: <20260910040520.4C2C51F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040319.1470=
37-1-sj@kernel.org?part=3D6

