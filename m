Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180313016EB;
	Wed, 15 Apr 2026 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216059; cv=none; b=LhyyRB6feVY0bMWL1fsN+qSWv4g4quhdwVO+mhiL9xN6KJi6/DUmcfIcDqVXVjm/I+4Ziafsw7Q2QQbLGUpke+p/v6CLb5QuqLL4gLBq0tvQpWYLPskFHhxUKu/GnfdAaKeadphmkW/lpZiRVUo5ifUN5YNXRszXC6/qVNvWBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216059; c=relaxed/simple;
	bh=Da5/SEejhoG/cyXVJpn39CgULzBmR9p+dGF7QD34w0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zf39zLgaCt1+URkTSu5kNsR/UvAigO/zSpeQa4RvMVNbsTDsjdM+BNgs8KXvNMMBF0uDl0O88+R8vGTYg74mcXYpDSyHVBIqCR7mTHLr5POcQZaWIIZv/tvTpjkH8F/VYnn2v0yccV3yJLUU5MVMZGRil/KFYFbf8IwAd+K83RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojB68Fzi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojB68Fzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E061C19425;
	Wed, 15 Apr 2026 01:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776216058;
	bh=Da5/SEejhoG/cyXVJpn39CgULzBmR9p+dGF7QD34w0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojB68FziWg70XqRdPmUGGSPM9jWyeQ4u7trrbqB1Hu3t6tG1YQXVtcaenU4cBf6ra
	 zUzQW8zSjRdN0UxfF0dE4bXQD5A/pAhUKi1iX32c9xDlHQpfyYw5OIbdJOKTCHMTqS
	 Z7bAmSg0KDpdRi0lzWxYKehwY3a20/hfE9GAPuUwwpdvGOaX3/tF484sPWQYVAbfkC
	 1vx/1AYP16HMLhc9UnI7mK9m/DLOM3toZXrBHus3FPoNp/jjGZ1kkV3vSVE48t8gFU
	 qDx2S0zXE+oRHQ0+UPG0XZwmnWdPHLO4w3h9E45MQKJkt9MbnPpMnA49bHqcmrprBC
	 fXrHGfeALiHqw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/7] Docs/admin-guide/mm/damon/reclaim: update for entire memory monitoring
Date: Tue, 14 Apr 2026 18:20:34 -0700
Message-ID: <20260415012048.76508-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415012048.76508-1-sj@kernel.org>
References: <20260415012048.76508-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON_RECLAIM usage document for the changed default monitoring
target region selection.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index b14a065586271..ec7e3e32b4ac6 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -240,7 +240,8 @@ Start of target memory region in physical address.
 
 The start physical address of memory region that DAMON_RECLAIM will do work
 against.  That is, DAMON_RECLAIM will find cold memory regions in this region
-and reclaims.  By default, biggest System RAM is used as the region.
+and reclaims.  By default, the system's entire physical memory is used as the
+region.
 
 monitor_region_end
 ------------------
@@ -249,7 +250,8 @@ End of target memory region in physical address.
 
 The end physical address of memory region that DAMON_RECLAIM will do work
 against.  That is, DAMON_RECLAIM will find cold memory regions in this region
-and reclaims.  By default, biggest System RAM is used as the region.
+and reclaims.  By default, the system's entire physical memory is used as the
+region.
 
 addr_unit
 ---------
-- 
2.47.3
