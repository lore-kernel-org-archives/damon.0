Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BA38F244;
	Sat,  7 Mar 2026 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772912547; cv=none; b=U2bdQ7LE/gikXdB7wiz3NnZA1ODZZfhxuTS8c9T/tB7Gi6eru1R5e/8+DYBp5KEc2OKGk83XtD3Hfsf3yGXEMT51ePR73GHTlTUAGKEtU2AnRvW4y4FqakEuJR6kVRhpg2d3hyvsmU7pcmbJNDIpXwThPZLLtAY0rSh7L1JJKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772912547; c=relaxed/simple;
	bh=hW/2ycay+HzENCaHwC79wBirLF865EtYyfXIYZ2Fx5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+1a6VaEOm8c8Q8BS/+R2fWYDN/7OCbEtbC5jqAGIlmZJtKrS4WmyCm4JR8cEC0ndHBWuF5DFSG5EdJ6fsDuZ/W9vwTc6GJq6US9k3SmyVphwwXbKotLYm7KeaS8h2ueX9E7Obv4mEoZNumXuIbhYN4RwwhiekAS6tPa44J4LVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxcdUQH0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxcdUQH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115ABC19423;
	Sat,  7 Mar 2026 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772912547;
	bh=hW/2ycay+HzENCaHwC79wBirLF865EtYyfXIYZ2Fx5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxcdUQH0a72LRUKSuKr2PQIYUV7QCuuqMbyh0lvh+rbp4NC15TkcqN7yqbsEiNNdW
	 UyC3v6strUjJ6vR7fJFz+JmYgiXuyJ859bS4erZvLJ1Bc9SHn9Az3SutHOxiyAUiO/
	 53e5x7bHFeoPboFbdotMv3aKrkbVBl5Igi6hJSb5nLKbc24BohDnqK28AO3dm2ZLSI
	 nzLAtE7QgfWRFdIlqYQneMIB7cUyB93R/V1oWqKdIg6D07IoHfqGpzCoYSRKnMGsKp
	 cFWDG5glsciRKnAnPBe7ZZM5dnVlT9Fzk7Zq+5UVpUQ9+lEh5zcfeWL3M2eY2QYL3k
	 SbZHA3hgnOFKA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH 2/2] Docs/mm/damon/design: document the power-of-two limitation for addr_unit
Date: Sat,  7 Mar 2026 11:42:21 -0800
Message-ID: <20260307194222.202075-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307194222.202075-1-sj@kernel.org>
References: <20260307194222.202075-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The min_region_sz is set as max(DAMON_MIN_REGION_SZ / addr_unit, 1).
DAMON_MIN_REGION_SZ is the same to PAGE_SIZE, and addr_unit is what the
user can arbitrarily set.  Commit c80f46ac228b ("mm/damon/core: disallow
non-power of two min_region_sz") made min_region_sz to always be a power
of two.  Hence, addr_unit should be a power of two when it is smaller
than PAGE_SIZE.  While 'addr_unit' is a user-exposed parameter, the rule
is not documented.  This can confuse users.  Specifically, if the user
sets addr_unit as a value that is smaller than PAGE_SIZE and not a power
of two, the setup will explicitly fail.

Document the rule on the design document.  Usage documents reference the
design document for detail, so updating only the design document should
suffice.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 28d932ceaf7ed..29fff20b3c2a9 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -150,6 +150,8 @@ address on the given address space.  Support of ``address unit`` parameter is
 up to each operations set implementation.  ``paddr`` is the only operations set
 implementation that supports the parameter.
 
+If the value is smaller than ``PAGE_SIZE``, only a power of two should be used.
+
 .. _damon_core_logic:
 
 Core Logics
-- 
2.47.3
