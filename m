Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00FF346A0C;
	Wed, 12 Nov 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962167; cv=none; b=o/Mng+nFkDu2Pm33T+ybkqC84AtGaRb2fkKHeM5G37/QQRmTfLZmssqh8m76CbTtpc+ir0uQBisiQLKyCTKwH8siPtXg/IeeIAMhFzbEn1EIKhLmu3RhAMHQ2XjawWRwQfBr9icO87dD2mf9QqTbDwj1OmbijB1aOxyfwFVRV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962167; c=relaxed/simple;
	bh=FBvB31rC2k0tLRJF6QYnzPfHs35FSu/tgti7HSN3rF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDB4qkVa5sO5/c5o4D6sMeaSyD7lh9sj374wmDwssEtRgfKH2otISfEYu+3B0ettOD+deojEpf2wbMKsaD52yRzEnuj3JWlpj1sJ9fTPdwThqg+1kVLR+OLSN0QnSsJjpk6SqFqMkU6I2ORIM4FBqBVKzi7Z7/HwNwxUUQvsUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uB+6vhcX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uB+6vhcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9C4C4AF09;
	Wed, 12 Nov 2025 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962167;
	bh=FBvB31rC2k0tLRJF6QYnzPfHs35FSu/tgti7HSN3rF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uB+6vhcXgD2N/irb6B7wVJSD0ZCkAohTi91IssEJMN5ne6QnsOoRIjSATHwXszAJP
	 KtwCRdxqtDCAbw63HqvPiHcVK1/ollFG5R5GF1vTt0cQkZUoiIBqEKDyZIVarM2GE7
	 byMmioNTmy+MlAzqC5Ia3j5zEGYbKg4lS5S+CoAgb2jLfGCpRIA3cU620h3SF7I/Nz
	 8hCl91wRfHQSzkBePKgMxNaSU8UQBiG2RasFpYimQp7eFui0xGIVKg5OP2UcAWld4V
	 vw+4DdO6eicqU0FkjKljiRcCsYseK7y1tWx0cwGjdlNPFhU4NeET2lzLv17Q6hvz5V
	 Io/xl7FbXk5ag==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 9/9] Docs/mm/damon/maintainer-profile: fix grammartical errors
Date: Wed, 12 Nov 2025 07:41:12 -0800
Message-ID: <20251112154114.66053-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112154114.66053-1-sj@kernel.org>
References: <20251112154114.66053-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a few grammartical errors on DAMON maintainer-profile.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index f1aed6e55d31..e761edada1e9 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -27,8 +27,8 @@ maintainer.
 
 Note again the patches for `mm-new tree
 <https://git.kernel.org/akpm/mm/h/mm-new>`_ are queued by the memory management
-subsystem maintainer.  If the patches requires some patches in `damon/next tree
-<https://git.kernel.org/sj/h/damon/next>`_ which not yet merged in mm-new,
+subsystem maintainer.  If the patches require some patches in `damon/next tree
+<https://git.kernel.org/sj/h/damon/next>`_ which have not yet merged in mm-new,
 please make sure the requirement is clearly specified.
 
 Submit checklist addendum
@@ -99,5 +99,5 @@ Schedules and reservation status are available at the Google `doc
 <https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing>`_.
 There is also a public Google `calendar
 <https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t>`_
-that has the events.  Anyone can subscribe it.  DAMON maintainer will also
-provide periodic reminder to the mailing list (damon@lists.linux.dev).
+that has the events.  Anyone can subscribe to it.  DAMON maintainer will also
+provide periodic reminders to the mailing list (damon@lists.linux.dev).
-- 
2.47.3
