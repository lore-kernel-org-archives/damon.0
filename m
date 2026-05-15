Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A461391
	for <damon@lists.linux.dev>; Fri, 15 May 2026 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808914; cv=none; b=MSW90AJVcAHdosmRc57l3s0u62pyxtMloPpORRonsOyVciDgYRouqZm/g4V8INlWHRe1z6esC8j/jTltbY6w2ZMGQ5f0gHmnN3K7EE11VdWEHyEpXJCrbPgNLF3tGmuV8u+b78ojyfyyMiHGUIEfwjsDuOBP0I9yVlBa5oPKToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808914; c=relaxed/simple;
	bh=ZB5xcubk11OBl4S4OdAxnt98sSrXV/qUUrtV5grAxG4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oKpIn6KrGy1J4Q63Umo8yOiQ/6PSziUeLEllKfpEGbYVp5x6CqJbktezyMxQkYTfUDvGF79n4Fjt6zbf1jvKRPUtxvzZ8KOE1h/M80LA4ODlQne5UdcoW3qZv4YYZp8S/Mr45Ho9FN+itceFL66xD+jhCR1MR3fu09A+VwAS410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMIDu6hX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMIDu6hX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7045DC2BCB3;
	Fri, 15 May 2026 01:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808914;
	bh=ZB5xcubk11OBl4S4OdAxnt98sSrXV/qUUrtV5grAxG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nMIDu6hX8tHIL9VAcKHqLdqbI8R2TYh0xgvvbGBwk1sA6qDmDEZXR7u6SL2JIGdBu
	 Z2j09V0gYgwwpAGJxSSPno0NEiBjTcIyKIBGFeaZHKLtPenSbqy8Tfrgsmf1a/3MgO
	 mKdKUVikleoOwxJeoaelQ9OnUG++iai9ntAgHqIaAlUJE4igDChfLMQ6apduiikepP
	 fTKpnrZiyktakIa/EWghE0hL7uYd60DcnqNFma+dlmDB5h4ULWQKHBvOTIwpUfWNyT
	 MkydRFHFbOBxssDaLFPdFFHTTdP8nf4swBhEn170obzsX1yG9jNvEwxUjcvwBbIhzn
	 ugBoRBe3juobw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 24/28] mm/damon/sysfs: add filters/<F>/path
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-25-sj@kernel.org>
References: <20260515004433.128933-25-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:35:11 +0000
Message-Id: <20260515013513.7045DC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The sysfs file is named 'path', but the commit message body clai=
ms it is named 'filter'.
--

commit de3638dbf8d1acc9d36bc5e5de54362c9f8fe540
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs: add filters/<F>/path file

Introduces a new DAMON sysfs file to allow users to set the target memory
cgroup for memory cgroup attribute monitoring. Users write the path of the
memcg to this file.

> Introduce a new DAMON sysfs file for letting users setup the target
> memory cgroup of the belonging memory cgroup attribute monitoring.  The
> file is named 'filter', located under the probe filter directory.  Users
> can set the target memory cgroup by writing the path to the memory
> cgroup from the cgroup mount point to the file.

This isn't a bug, but the commit message states the file is named 'filter',
while the subject line and the newly added code define the attribute as
'path'. Could the commit message be updated to more precisely match the
actual sysfs file name?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D24
