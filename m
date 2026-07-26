Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4773BE62A
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087950; cv=none; b=OKuHJDcozXm3ZZH0MrIPOCqF7F21cQFC5+e6YNIAESNfhPVAw1EWaKMWc0VYGu8QR7MqcA5BasVWTOt7cvYKADI3kAEH3aM2fVtLRThrkhcbt9giFUWHd2l/Z2E/z0nC3KpWf1cirKcjcxepCqKURkVIv+g+scke7oRc+CPM01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087950; c=relaxed/simple;
	bh=Rha+d1X2zWzBPYmSkDA9k+C3qWJ9e5OggLIa/OUmcGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QiHJ/w3Y2etWrEYaJrw5XHMB1hTE3NTbqIx09yltB9tFAhn+YwVemFjIK+FebertMn/MbApVTr+65Eh5UaPlDnwcpKeArC2jMC25Qf4GOROKaEHgmxnvQyCD/OcicAXNXPL73L+PqoO6CLbizLoztT66Qns5uwX8yGxEA1uODgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOkzCcCx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOkzCcCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399DC1F000E9;
	Sun, 26 Jul 2026 17:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087947;
	bh=OkeE0U6/ISJSKhnQDuanVvlSSRgwz3cKKaRwmiu722k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kOkzCcCxmOBC3d6A64VL49Pxgslp5tAeEvxHx8OHILFO0MrPU9qDp2tZV2e+WosOy
	 GHENGh9RZnI1k/S02q8dZw6qzmFb8Yu0IyQ6zfRUYJzSuTKhUqIU1uLzuW3/H/4Mlu
	 8VbVlWQI9/VgK/52OHiX/nGjX2HAuUnyd3fkUst5OpFgezBG/fZbInr0J/2NZH1JXj
	 cO4tYIK2tidggdISTc7Y6bcr6gW5kL0NsOzImp1U4oJiLELxTJre2GnSMA8Fpnfdtt
	 dPLU5cdLnHdAFky++tjkVSJXbZw4ziazwwSazt5sJ7Jl/0Pk9sY2RfU98jmKWn+ro1
	 TX5t258EZ+3pw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 17/17] Docs/ABI/damon: document probe prep sysfs
 files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260726173935.94046-18-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
 <20260726173935.94046-18-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:45:46 +0000
Message-Id: <20260726174547.399DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The sysfs path for the `prep_action` file is documented incorrectly=
 as `prep/<R>/prep_action` instead of `preps/<R>/prep_action`.
--

--- Patch [17]: [RFC PATCH v2 17/17] Docs/ABI/damon: document probe prep sy=
sfs files ---
commit c668115a6c46349a2601c78b7bdb1229021f721a
Author: SJ Park <sj@kernel.org>

Docs/ABI/damon: document probe prep sysfs files

This commit updates the DAMON ABI documentation to include the newly added=
=20
DAMON probe prep sysfs files.

> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentat=
ion/ABI/testing/sysfs-kernel-mm-damon
> index e675a57145e36..f913f4eee4b4d 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
[ ... ]
> +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_a=
ttrs/probes/<P>/preps/nr_preps
> +Date:		Jun 2026
> +Contact:	SJ Park <sj@kernel.org>
> +Description:	Writing a number 'N' to this file creates the number of
> +		directories for each DAMON probing preparation action named '0'
> +		to 'N-1' under the preps/ directory.
> +
> +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_a=
ttrs/probes/<P>/prep/<R>/prep_action

[Severity: Low]
Is this path missing an 's'?=20

The description above states the directories are created under the preps/
directory, but this sysfs path uses prep/ instead of preps/. Should this
be documented as preps/<R>/prep_action to match the actual sysfs directory
name?

> +Date:		Jun 2026
> +Contact:	SJ Park <sj@kernel.org>
> +Description:	Writing to and reading from this file sets and gets the pro=
bing
> +		preparation action.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726173935.9404=
6-1-sj@kernel.org?part=3D17
