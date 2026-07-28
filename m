Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B0386576;
	Tue, 28 Jul 2026 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211976; cv=none; b=otCpV0HDtftWP1SVM06PPSY/Sa+zxreVo62nkjPaNj+dAUL2WC5mzc2hbWEzPAZKcClgDi2Qkzuh3rlw3YJiziZoU3ytKmbX0K8NnQ9NyDn+ecvrNVktf7zo7WTndh/gToqB7Gs1LVj8MR1hvZ1ZsRlhy3+mHDKUvlKI29vHgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211976; c=relaxed/simple;
	bh=BoQmFAANRs5ejoJBSDr2ocPVWNj8V5kOrKo+q+5Og7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+Z+RzUY5j4K57CbySD83/DVXIiYBgberheiVebKwhB1ShlsPV0KZYROcJzX9W25EccPsbK6Qk4/gUq6cvwxiUIdJqhvxe6mi9mAGjjzJYivOqA3chVPZ0nqVZ+C3y7aBBRli1GfJEiriW25G8cMVEu/jhW/0Kcgtxfz/DIuI/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTgkhxAj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTgkhxAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0771F00A3F;
	Tue, 28 Jul 2026 04:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211973;
	bh=Qlh6y9Au18vR1Ou/T5ICe3OGlXl5Nc84fCTR2Y+rZXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aTgkhxAjPDwEY5OdQK7osbfQu9Mzfd5JomJmpe9Ij8LREGuMPl0mkLW9WK3Gl9T1a
	 zdpQjLUzW/ir4y7Bkrr+MZZCqL+fMzKQeplrCpf5NqzdIS3+CtYAKW7iXLIM3qNNUP
	 jYwjlY4gQ7PkXG7YOYI/CZ11apvsASV+hcIlhqPJo8n2YytaG7QiN8WkEH7pk/LW+7
	 9gf3FmI/x1/W1mKS3OeXDBE8szcqqyg4CSX5+V0SP3uGcUF9KXeseOeSEme77rvUbm
	 A0Qe0oe9lSNQDDOUm05yxXZl/MjMFj9qEKbWDZJvGg5YC39UJyoDxa+FWZGttzd+Yh
	 ELM4IsxQfTdjA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [RFC PATCH v2.2 04/17] Docs/mm/damon/design: document pgidle_unset probe filter type
Date: Mon, 27 Jul 2026 21:12:25 -0700
Message-ID: <20260728041242.187380-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728041242.187380-1-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added pgidle_unset probe
filter type.  Also use a list for the types, as it becomes not very easy
to read the whole types in a simple sentence.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index a8c163475ef2b..c4830bd09498d 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -293,8 +293,12 @@ registration is made by specifying a probe per attribute.  Each of the probe
 specifies a rule to determine if a given memory region has the related
 attribute.  The rule is constructed with multiple filters.  The filters work
 same to :ref:`DAMOS filters <damon_design_damos_filters>` except the supported
-filter types.  Currently only ``anon`` and ``memcg`` filter types are supported
-for data attributes monitoring.
+filter types.  Currently below filter types are supported.
+
+- ``anon``: Same to that for DAMOS filters.
+- ``memcg``: Same to that for DAMOS filters.
+- ``pgidle_unset``: Matches if the page for the memory is marked as not
+  access-idle.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
-- 
2.47.3
