Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1861F09AD;
	Tue,  7 Apr 2026 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523941; cv=none; b=UnxyrW5fmeV/V+nHPwd8LY6kKJrBXPz2ugnKnNcfoS4dQp5eLj61Ke/V1n9OX29/jR/kXEdcOeLvUT+z32pbqPtMk8HxQynsoP1tQzx2qtZAzVjNbRLjGnzwvvLEnOIpClPWkCwBGIT2tGpI2Xsh5KM0cfH0HB2HDElXa0vQ+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523941; c=relaxed/simple;
	bh=88ilcTiVHxOBPfSO6beti3cUyMc/KjPaTfyvCKtApUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIy5Uy/3FZcUmGIK1uvD7JUBWgYr+5+czMUlWZU1DxLpZeOofyZebbvLJxGoKPGZZZ/A8I0AdfiwAZIpvXlkVOpmL1myc3JvRkVC4V1byPTXFRJ/w91WeB4gdgvfoZA/9hOL+S94Z+I24kyqFVUfY/wmjlL6ioLoblrlVxQnCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDELN9Uv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDELN9Uv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1176EC19421;
	Tue,  7 Apr 2026 01:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775523941;
	bh=88ilcTiVHxOBPfSO6beti3cUyMc/KjPaTfyvCKtApUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDELN9UvJpK+m+DGX2EfCnEss58wKhuhwSkXuXXfP4u2MlMgI50oaavE+X3D9m4Ii
	 x/0jSuwR0bxO7Q43A39xQR0NgC3NfLswQiOYBwmtNAPtNWpl+JHAs4kma3iZnqA9Ku
	 DOh/2wMSj2XDQ4zhp0Y4MWdGLmWMQJouoHplXMIj/qXsni5a9aI9VEUAGVYpYZvDCk
	 vdm8i1uahCo51+NmKHsK9xE9hRpXnEyZTqIk5iUxRCdpBuhDaQySHVj1Xq2FbLeIEI
	 AMyKymwt82Z5nKf69ZKRGYLCQte9tUAF9qCaY05ln8FlP7g0oE7Wcxrm9IL927az2F
	 j/1xc51FzywWw==
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
Subject: [RFC PATCH v3 04/10] Docs/mm/damon/design: document fail_charge_{num,denom}
Date: Mon,  6 Apr 2026 18:05:26 -0700
Message-ID: <20260407010536.83603-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407010536.83603-1-sj@kernel.org>
References: <20260407010536.83603-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the DAMOS action failed region quota
charge ratio.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 510ec6375178d..94e898b671d15 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -572,6 +572,28 @@ interface <sysfs_interface>`, refer to :ref:`weights <sysfs_quotas>` part of
 the documentation.
 
 
+.. _damon_design_damos_quotas_failed_memory_charging_ratio:
+
+Action-failed Memory Charging Ratio
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+DAMOS action to a given region can fail for some subsets of the memory of the
+region.  For example, if the action is ``pageout`` and the region has some
+unreclaimable pages, applying the action to the pages will fail.  The amount of
+system resource that is taken for such failed action applications is usually
+different from that for successful action applications.  For such cases, users
+can set different charging ratio for such failed memory.  The ratio can be
+specified using ``fail_charge_num`` and ``fail_charge_denom`` parameters.  The
+two parameters represent the numerator and denominator of the ratio.  The
+feature is enabled only if ``fail_charge_denom`` is not zero.
+
+For example, let's suppose a DAMOS action is applied to a region of 1,000 MiB
+size.  The action is successfully applied to only 700 MiB of the region.
+``fail_charge_num`` and ``fail_charge_denom`` are set to ``1`` and ``1024``,
+respectively.  Then only 700 MiB and 300 KiB of size (``700 MiB + 300 MiB * 1 /
+1024``) will be charged.
+
+
 .. _damon_design_damos_quotas_auto_tuning:
 
 Aim-oriented Feedback-driven Auto-tuning
-- 
2.47.3
