Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8006825B0B8
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 04:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784004762; cv=none; b=he25Y99oaLb0jVUDnVnkOoL7WDaxh58GQUX66IFNU8dEh3eCKxIGSda70FkbCnaUa46oIHENCo0iWAJzz96f3JkZmrFaOLiv/4Yxtwv/CvIn18LYOMo1NlcRNOhjBWUIH3fKD2vuYwXIYsYkikuPOU41LTDUcxLGx7yxr2XXYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784004762; c=relaxed/simple;
	bh=9XvUFS9htyOzhawiGDFD1u04R9xFsKfn3hqxnQiyTUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NoGrd6qJp+t+L4N/5dthXzJZNOKLuktxRa3IKeNlOAs8B82Ri3NPIgCmRo/queNdSjs98PkcyPhGQxR3SN0W56Aliqx/ps0mSzBUVBzzFYouk10tmGbbnZR7j24u1G7sVvv5aDGq5zM5kssbqtHUA5LWbY0kT13XeJfmKXtn42I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iL599FKB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iL599FKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E611F000E9;
	Tue, 14 Jul 2026 04:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784004761;
	bh=9XvUFS9htyOzhawiGDFD1u04R9xFsKfn3hqxnQiyTUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iL599FKBx/qiKN5F8w/1Upeftiw5m4z+X50eETRnHQ0YVpIu7Vh6lNc+KBGk6qRBC
	 pflFQumXn79a4jUX5nmVoEwbk1gZxGkKWD8CbAfDaFuaTqxrKgAysGIXRp76c8gVmO
	 GCO/LIkcYfx8V/LliNFo4eIhdjj2KQ26QmiDhYTwwW48p+AdCA7eYZ/8gxoT4qg8Uz
	 T0JCVyuh1PChfHUc+6KGF0Cl5Jo79DVng2EHtGAxfRfe4nv54avLSBvk9NEUuN1Od1
	 AyC1lvtYOZCA5uWjJepX6gwcnLiFr9P03ZyNaM99aK53y8XVdYuWez+l5qPWiMGOX4
	 YkauBAY649aqw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/10] mm/damon/core: hide private damos fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260714043437.95811-7-sj@kernel.org>
References: <20260714043437.95811-1-sj@kernel.org>
 <20260714043437.95811-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 04:52:40 +0000
Message-Id: <20260714045241.08E611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `struct damos->last_applied` is left uninitialized upon allocation=
 in `damon_new_scheme()`, leading to a potential read of uninitialized memo=
ry during the first scheme application.
--

--- Patch [6]: [RFC PATCH 06/10] mm/damon/core: hide private damos fields -=
--
Note: The format of this report has been altered to provide a free-form
summary instead of quoting the original patch code directly, due to system
recitation restrictions.

commit 74f6565901cd9e992427e68af079cc1885de502e
Author: SJ Park <sj@kernel.org>
mm/damon/core: hide private damos fields

This commit updates struct damos to hide several fields intended only for
the DAMON core layer by moving them under a private comment block.

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the changes
to the last_applied field, I noticed a potential uninitialized memory read.

In mm/damon/core.c:damon_new_scheme(), a new struct damos is allocated
using a non-zeroing kmalloc variant. While several fields are explicitly
initialized in this function, the last_applied pointer is skipped and
left uninitialized.

When kdamond_apply_schemes() performs the very first region walk, it calls
into operations layers like mm/damon/paddr.c:damon_pa_invalid_damos_folio()
before last_applied is ever cleared to NULL.

This causes damon_pa_invalid_damos_folio() to read the uninitialized heap
value and compare it against the valid folio pointer currently being
walked.

If a local user configures DAMON and the uninitialized heap memory happens
to match a valid folio pointer being walked, could this result in an
erroneous folio_put() being executed prematurely? Does this open up an
exploitable use-after-free vulnerability during the initial scheme
application?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714043437.9581=
1-1-sj@kernel.org?part=3D6
