Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478541;
	b=ZZ8Cvwex0xFgNnUnbce5WMpBOJ3BJY998Jf07i8808pf3yCNjeLGPmi8UP5g+qNORU6o
	 XLQgQVsarYL8ZebyuquCt6HH30RYY/xH9b7LgYbYnzSxghl0r2PZMynKGwcUHRCDZVrny
	 mbU1uWKV1zuqUF9nj2GKj3wGe3SVTxxVMFLPurXZJ0taprwR8mqitF+pmWRhykNSQrDJq
	 ZwogGRyJwnxEAMZjTlVdCCG4IodXaCmSZWZthdT4ehEFPqU6KWsrX603bMGvcOW5mh9vd
	 DrK7aav1eFWInnpP78IRU2ujiPZkqUVqonZbcE+Or2N0kKYMps1V6UatkVMEuU9/l6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478541;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F2JHwEtDf9D7TWTWSurLCwRlzX6xohlUFs5XtZvypmk=;
	b=cgKZ3pHEjRMkHMUlvth0jdvXWrrtrZy/bteGWmG/2kYuq/tIaqho8XVmcXgt1VKiPYO4
	 /Nbi2q4FBmEze6FAsrebkHDDoKlpYJnfBvL4SZtj+cEibwUhf/ywO2cYNn0E8fqydmYep
	 w2dSROPcPdSH9bJzQwGTu6MKFByl9L6BTx51JFMK/5BcQH56kNtC8qtnO3x00wdm4pA4U
	 JYSqfjfobuGpk0/1QLL7q9ehiAbXKcQzQELqZ9R6wXoQTCoa1wC1EUKrw35SqM2IpZF71
	 psOJUPyXXIoGcuwqVNS5oSbiHyVUTJTy1WCXuqGnJhXPem8eSvNShLIJWggTQ0EJSkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qm+fVmTi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD4606A31C
	for <damon@lists.linux.dev>; Sat, 31 Oct 2026 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qm+fVmTi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760F71F000C1;
	Sat, 31 Oct 2026 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793478540;
	bh=F2JHwEtDf9D7TWTWSurLCwRlzX6xohlUFs5XtZvypmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qm+fVmTiP5YQVGyMNUQskoohBCdoe4RPYkTh6VwfWeR+c1Bd+N7WtG1Blbz7fJDH1
	 8oXAQYvGKHcgqixycxbEp9m+PrZ++Ncvpz9sWTT9Ywf14aRRp9TR92i0m/l15bvVQs
	 ITjwgXCUS/OAj+MMcCIMVIurlaNuZg9ac3br4ZRhouVJLhT/VQVAhJwiiHBvQgDnxI
	 46eDDm0WJoI39YlGj3lvXtt0ujUt5Jv9G59PRiuk0vQCCQTFj5JrbNoOrQJrYNBLdp
	 V7//DvgfYY7i8/zd0HQWve4PegoKeP39VCcUEjZMTnonOJktX41eOP1lSTcNdlmOXL
	 mLIbgYTePnQqw==
Message-ID: <sashiko-outbox-192115@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/6] selftests/damon: remove unused imports of os
 and sys modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Shuah Khan" <shuah@kernel.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261031202614.96036-7-sj@kernel.org>
References: <20261031202614.96036-1-sj@kernel.org>
 <20261031202614.96036-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 20:29:00 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/damon: commit message names wrong removed modules
--

commit 55304159b940aad6f9b71d318671a40d9d63ca46
Author: SJ Park <sj@kernel.org>

selftests/damon: remove unused imports of os and sys modules

This commit removes unused Python module imports from two DAMON selftest
scripts.

>     selftests/damon: remove unused imports of os and sys modules
>    =20
>     sysfs_no_op_commit_break.py imports os module but never uses it.
>     sysfs_update_schemes_tried_regions_hang imports the sys module but ne=
ver
>     uses it.  Remove the unnecessary imports.
>    =20
>     The issue is found using flake8.
>    =20
>     Signed-off-by: SJ Park <sj@kernel.org>

[Severity: Low]
Does the commit message name the wrong removed modules?

In tools/testing/selftests/damon/sysfs_no_op_commit_break.py, the patch
removes import sys rather than import os, and os is still used in
dump_damon_status_dict():

    file_dir =3D os.path.dirname(os.path.abspath(__file__))
    dump_script =3D os.path.join(file_dir, 'drgn_dump_damon_status.py')

In tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py,
the patch removes import time rather than import sys, and both sys and os
are still used at module load time:

    sys.path.append(os.path.dirname(os.path.abspath(__file__)))

Should the commit subject and message be updated to refer to the sys and
time modules instead of os and sys?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031202614.9603=
6-1-sj@kernel.org?part=3D6
