Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554725;
	b=GbIeDjIPLqEwsd8Qmo0m0/wUhj+de4J48idSVFbZ8ijaf5rGUhgW+Ed+5m/0ybU98MqN
	 cgmcBXkrMAnCDNaaaMtkWP5pTeqzYyE9MgZNs9Krnu5Xltw9D2xQdck03sBDM2P9EKIuf
	 QZIylA3JE6tmK56C6dl+vyQ/ReMwzi76C/TykOFW0dS0G2G58M8HBh8QyTKPGJzKIJSpm
	 PwwlNx54TIvChvab+8enfKe5DotYE5kYcgMw0LDE5B+73gF0fVnK+j3lfbycYqOARhL0K
	 p9P1SP2/eEMdtJwlef/jmezaUALuZn4JypQpaa5mUvIpWNEKvdE0z/c4Dahq3rEdt+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554725;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PAth9uuBsiD2ZBusvqK9jhofezKOh4eMDf+spvC6ZS8=;
	b=ChSbnMqtqVfRrnq9yA9Bh1acZWHqck/3JsplunIqAfa4C25xz3ZGQBhIKVNOTo0xtdfQ
	 MgKibiLN5x7ttsCN194lm2yCxGzLuGJjZ9p5kZCRe+SMcTzdBhK1RvRvVbYF1fITQwBCf
	 VfdgV93EwvQ6C658pExC1YQBrDUhE7YIUbTkK8N588J6vfQXUnDyUJkazKUNAN1povfbs
	 5gp+Hl8J73BjiMwfimNfQV+7Bib9ZLrHy1KTLCidOxpF+ZLtY1+tPHBiGphx6DUnjcmv1
	 eTfv4PQv6CXoTan7cr1RDDf1OgApnkdyMOy2N5wfNEULFfpyRQw2dnk8zrsvJ7ePoGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQ8VzZvS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085CA606A324
	for <damon@lists.linux.dev>; Sun,  1 Nov 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQ8VzZvS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC651F000C1;
	Sun,  1 Nov 2026 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793554724;
	bh=PAth9uuBsiD2ZBusvqK9jhofezKOh4eMDf+spvC6ZS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kQ8VzZvSgspbzf0SuM8xUN2hyNsa3Eg74XNmydQiskesNLCOsRNB5olap9pQpi1VB
	 CCcI8te22TpleARbiUDmhCAqU5Lx9wNMBlTeBloBVweDq8uemlzyIb+r128NtFhz1W
	 GX6WBNAWszmFdHRHb+Vhm8BEnKEKydTJ/zD1oDy4E+JEOeFNFAJjB0P1SvPUzNF//3
	 cgp1uMut585Jy5DXx6iq+N+ECqXK07GCmFuFcOO2MUbwagmcTfODhuNyUcU+DiPnhV
	 gGf6AjCETFkciKdSY5uW7YCB/q5igRf+lAKlJA6qtg+vC9W+vdNEgzkcDpfnr0ArXO
	 CUVJp7zt0NeTw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Shuah Khan" <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 6/6] selftests/damon: remove unused imports of os and sys modules
Date: Sun,  1 Nov 2026 09:38:36 -0800
Message-ID: <20261101173837.82868-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-192521@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 01 Nov 2026 17:20:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] selftests/damon: commit subject names wrong removed modules
> --
> 
> commit dfc99fb0f6f595e8bf824229e67f0b391cab2a8e
> Author: SJ Park <sj@kernel.org>
> 
> selftests/damon: remove unused imports of os and sys modules
> 
> This commit removes unused Python module imports from
> sysfs_no_op_commit_break.py and sysfs_update_schemes_tried_regions_hang.py
> in the DAMON selftests.
> 
> >     selftests/damon: remove unused imports of os and sys modules
> >     
> >     sysfs_no_op_commit_break.py imports 'sys' module but never uses it.
> >     sysfs_update_schemes_tried_regions_hang imports 'time' module but never
> >     uses it.  Remove the unnecessary imports.
> >     
> >     The issue is found using flake8.
> >     
> >     Signed-off-by: SJ Park <sj@kernel.org>
> 
> [Severity: Low]
> As reported by Sashiko on RFC [1], should the commit subject be updated to
> refer to the sys and time modules instead of os and sys?

Yes, I forgot updating the subject.  I will do in the next spin.

> 
> In tools/testing/selftests/damon/sysfs_no_op_commit_break.py, the patch
> removes import sys while import os remains and is used in
> dump_damon_status_dict():
> 
>     file_dir = os.path.dirname(os.path.abspath(__file__))
>     dump_script = os.path.join(file_dir, 'drgn_dump_damon_status.py')
> 
> In tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py,
> the patch removes import time while both import os and import sys remain and
> are used at module scope:
> 
>     sys.path.append(os.path.dirname(os.path.abspath(__file__)))
> 
> [1] https://lore.kernel.org/r/sashiko-outbox-192115@kernel.org
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261101171630.81477-1-sj@kernel.org?part=6
> 


Thanks,
SJ
