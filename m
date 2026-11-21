Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795289623;
	b=NU18rFlmqLf86kjHW6sSdMftAXNqqBU9mwCJEH5quDF4qnle5VFUXVCXXeB1Nc6ehkrG
	 1aRP3x9QCQQW33mZ54g2fjc6cI3xXnosUBhJsmBQsBHtBVZbgDv5IoZk/FQcaUnvylvnf
	 D/cy26C3nBB7FSgDDulctKcytELEpPoJOX/eOpeeDuXJfoIyYVWnDPph2/uSjmBjsm+HG
	 e64ipEkydJXyHu8j6Ao2ZsWli3kc+2CdQ53KMBmHEPtLDBQSgziGG4Nh6CWhXIq3jeUs/
	 4wwwkjPBlbZmqzxoLJ7m1pmxSnTthXVuJ+adwUtK+xyxQqkyL0oLkxHULisxObRRwZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795289623;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xi3zTL53/C0IsEtzXdFhLsnsp6QQLU3JdQrRy1JaaPk=;
	b=TMR3+yi5NrfJS9XdL69A1ypB1cnrSMAkarNO9Wa+lF4CZcdl63HDKU4P1oPEWLtb7zTg
	 o05syp1aSMhEwOUVknuyTF7OQSyiWtSMbUBXFOeJ/BFX6GBTfYu7lt8Dx725QZJYwrgKX
	 5dgSF1bF5y7/QHTw5cx4MbR+KGoQJP2zBt38QZJaVagMWNRk+3SuJFujZJBLGCJWQBdeR
	 4lqxzZ4BkitCMK/dABPd0tylyN/v2lZ1D6Po2bPySUTOA6KIL3E4goWRVcBbFqPFwFy1a
	 Ksc8VJh+TA5ZPufBTZ02VHZEPiIaxOHrjbA+jJ5IUdsbhqB+VqMUE5el0VT4j/6WqOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knozuAXc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE3606A681;
	Sat, 21 Nov 2026 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knozuAXc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1481F000C6;
	Sat, 21 Nov 2026 19:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795289622;
	bh=xi3zTL53/C0IsEtzXdFhLsnsp6QQLU3JdQrRy1JaaPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=knozuAXcAd4tXwrmiaQ6EyXhjtrKKjBm7PKg55wzunpzVBgWlcgk6coXmeC735AsO
	 dk10iOkF4ac0OCuRbxmiU+a3aHnZkoWQAi81SC6ut+lhrLKxZlpZxxSGcsu8qu+Cmh
	 kOyBoompk9vWsIzX2mOeCLSVyE8aGV9eObqNZq8MmJxHNdPHXdFvgkLum1a+tqfWSL
	 ORrELJWfyypz3sYusN0iX18je/blLnGUUqDcRSbwDoq4W9QB5KBdoulhJ6NM+cpODk
	 UyvZRQxlKeA874T83VtTXfljzYBk8jSGh1Gl46DenuEhAHxXSZdHClmBKT27yhBDqv
	 8Qftah592vYUw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/4] Docs/mm/damon/maintainer-profile: drop 'SCM Trees' section
Date: Sat, 21 Nov 2026 11:33:28 -0800
Message-ID: <20261121193331.108587-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121193331.108587-1-sj@kernel.org>
References: <20261121193331.108587-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right after 7.5-rc1, DAMON will onboard the mm-next transition [1].  The
major change is that it will use damon.git [2] as its SCM tree.  'SCM
Trees' section on the maintainer profile document will be outdated.  The
updates for the new process would make the roles of the new trees clear.
Hence 'SCM Trees' section would be no more necessary.  Remove the
section.

[1] https://lore.kernel.org/bed81e01-7303-4957-bd7d-38e3a094e96f@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mm/damon.git/

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index cc6b79c066a64..f9a8df2b11e73 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -18,26 +18,6 @@ the reason and what baseline is used.
 
 Patches should be posted to the mailing lists whenever possible.
 
-SCM Trees
----------
-
-There are multiple Linux trees for DAMON development.  Patches under
-development or testing are queued in `damon/next
-<https://git.kernel.org/sj/h/damon/next>`_ by the DAMON maintainer.
-Sufficiently reviewed patches will be queued in `mm-new
-<https://git.kernel.org/akpm/mm/h/mm-new>`_ by the memory management subsystem
-maintainer.  As more sufficient tests are done, the patches will move to
-`mm-unstable <https://git.kernel.org/akpm/mm/h/mm-unstable>`_ and then to
-`mm-stable <https://git.kernel.org/akpm/mm/h/mm-stable>`_.  And finally those
-will be pull-requested to the mainline by the memory management subsystem
-maintainer.
-
-Note again the patches for `mm-new tree
-<https://git.kernel.org/akpm/mm/h/mm-new>`_ are queued by the memory management
-subsystem maintainer.  If the patches require some patches in `damon/next tree
-<https://git.kernel.org/sj/h/damon/next>`_ which have not yet merged in mm-new,
-please make sure the requirement is clearly specified.
-
 Submit checklist addendum
 -------------------------
 
-- 
2.47.3
