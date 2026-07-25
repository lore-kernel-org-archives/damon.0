Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3836493C
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013969; cv=none; b=eaG60CwdeuBuoWPDtWV0+W/qg3QQEl11Fko34ExhS6LEoaTtwHEE/seBJ1RqxjeR1l1SY72FNl9stmiPfFhLT0JwNQhWfhhLgjbyi4D7ebmuCeF1Y+zguFJmHfifpQAwW0yv8sQXttzq6ggp3oqz3IZZM6Hj8OFf11NOSs2pOTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013969; c=relaxed/simple;
	bh=kDjOrz7uRVsylAn4LY/jSSbrNbgNt/lDoiep4ICrfws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzel6hb6QaIws1LIUQnua/SDk1QQLvUCRrcZZSjBLQCOuEAO0niU+Tx22XIreUR9u2Wi3LGsa86hi3KBE27RqS8JvbOwH7SX2F/eqJxiwWobu2P/5GYbNySMaberpqGUvmkFe3VCo5hL3g/+UwlZ+Vy+xitofkyTtseLBTmUTJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZhUszUb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZhUszUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098301F000E9;
	Sat, 25 Jul 2026 21:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013968;
	bh=wTSN5I8BfCnjpbpPk1P4WGxAZ8GnVvf/74dNJ+Z5xiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZhUszUbLAzcI88RE3NznNcWON1kOaCG3Q0nteEz2G7s974MZPgTkvEF9Fz/Qa+w6
	 hf2R1CRmXJaIL8Nl98UI3wLdgdHByksdyRhVvDTOeP00nWQBR9MWrxbNGc4m+fFKZw
	 WTQjPNEju8EWPTPPWjEPT8H1ntPkQOEU9Rty/HVFZ7GN20axd7nOSQqEo7npc0IDBg
	 hnaxv/gY3cIInqUTIvgo9rdQACoBwMT00gmDrJdHP3wAxygY0rpkn6s4/GEYGSM/2C
	 Sam5XMvLPIlSCCLEsT4nK5jxj7Lr85+5pi2uwJgP2fX4GZS3c5NI5+K4O5VtnAganF
	 esk/NfV+c1ABA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 17/17] Docs/ABI/damon: document probe prep sysfs
 files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260725210225.129944-18-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
 <20260725210225.129944-18-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:12:47 +0000
Message-Id: <20260725211248.098301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The documented sysfs ABI path and filename for DAMON probe preparat=
ion actions do not match the actual kernel implementation, and the descript=
ion contains a typographical error.
--

--- Patch [17]: [RFC PATCH 17/17] Docs/ABI/damon: document probe prep sysfs=
 files ---
commit cfe472afe661c1a2901b08aa9b4dfa86ac237ee5
Author: SJ Park <sj@kernel.org>

Docs/ABI/damon: document probe prep sysfs files

This commit updates the DAMON ABI document for the newly added DAMON probe=
=20
prep sysfs files.

> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentat=
ion/ABI/testing/sysfs-kernel-mm-damon
> index e675a57145e36..6d596fb7fa1ff 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
[ ... ]
> +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_a=
ttrs/probes/<P>/prep/<R>/action
> +Date:		Jun 2026
> +Contact:	SJ Park <sj@kernel.org>
> +Description:	Writing to and reading from this file sets and gets the pro=
bing
> +		preeparation action.

[Severity: Low]
Does this documented path match the actual sysfs implementation?

Looking at damon_sysfs_prep_prep_action_attr in mm/damon/sysfs.c, the=20
attribute file appears to be created as prep_action instead of action, and =
it
resides under the preps/ directory instead of prep/. Should the documented=
=20
path be updated to preps/<R>/prep_action to align with the kernel code?

This isn't a bug, but there is a typo in the word preeparation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210225.1299=
44-1-sj@kernel.org?part=3D17
