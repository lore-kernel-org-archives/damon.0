Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5064435A83;
	Mon,  6 Jul 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347567; cv=none; b=pllMLkNYba2KCK4zRDWDas2HHbuA2iq+arqHikX1dy7mGx3BQn5YHmOEK4FHb85KTAZqVEYQrxwj29pFqQGNqtNT86ndBRr2f7BU9yTIk5CApMwLFV1rUTz3JcwBNQQp200+7IEpK3j7zxq9fW6Lo/qqUQtqX9L7suvVGR38om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347567; c=relaxed/simple;
	bh=kSvPkTqUMQuNngP9MOjUUXHc6wov0cmX2dXhh/hqB5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qk3nnkyQy+8xoxiOjEzmcvdfcikOZsDw2K5GeFXjsi1673rAmnxLIhRBTSGGWCdvnD1+fbNo1JXiwjpHXhd51/MH7h2E1/B5Gvt0vuGES33N9z9ctEMJy4JDD4LnYAa5DHtpFZVQY/i7FkUOHWmLFNLXI7/CUp2iK1egjL0S42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4/Yu1xa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4/Yu1xa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2371F00A3D;
	Mon,  6 Jul 2026 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347565;
	bh=8LCoQX0bHg1OYdjWEvzo4RN1ftxPbEZ5h4yD4yU742Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A4/Yu1xazNWRvU2HtJFDKJuoxFxspbxkBVePK0mvBDXbfSPpQ6ReFMeI4NJh4L96G
	 SBZ+69qPfHZvsTAgH2OaEA7C8K6vAWvD5QKO8w96jdv0YdwgGncF3misB+kQ0IvsCW
	 I9ukCWIWBzR0cICQW2ImK+6WuIp0XOPZMMHWgqlm1QASPj6uZYC5LEoDfC2LtqmjtU
	 jU0LVNj28xlDvokL+xr2WsFaE1Ow5igeIhr0P/WMkp9oxLlyLPs61GfGF8Lcnx+QNu
	 pX0dHxP14KhRqau0KAuHWu4hn6o3Z98V9RMOR3MQGbYSJF6A3QZL4DPxY/OLiQO3bw
	 2+HLdu4Z8Ad6Q==
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
Subject: [RFC PATCH v1.1 14/16] Docs/mm/damon/design: document attrs-only monitoring
Date: Mon,  6 Jul 2026 07:19:08 -0700
Message-ID: <20260706141912.88445-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706141912.88445-1-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the attributes only monitoring mode.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 457d6e8bc7878..6d79e7d69be84 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -316,6 +316,26 @@ Another way to do this for higher accuracy is using :ref:`DAMOS filter
 information in page level.  But, because it is operated in page level, the
 overhead is proportional to the size of the memory.
 
+Data Attributes-only Monitoring
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Data access is the primary monitoring information for DAMON.  Hence it
+:ref:`adjusts <damon_design_data_attrs_monitoring>` regions using the access
+:ref:`counter <damon_design_region_based_sampling>` (``nr_accesses``).  In some
+use cases, however, users may want some of :ref:`attributes
+<damon_design_data_attrs_monitoring>` to be the primary information.
+
+Data attributes-only monitoring mode supports this use case.  For the mode,
+each attribute probe has their priority weight value.  Users can describe by
+what combination of the attributes the primary information is decided, by
+setting the priority weight value.  If the total sum of the weights is not
+zero, the mode is enabled.  The regions adjustment mechanism uses the weighted
+sum of the :ref:`probe hit counts <damon_design_data_attrs_monitoring>` instead
+of ``nr_accesses`` in the case.  When the mode is enabled, access monitoring is
+automatically turned off.  The access counter (``nr_accesses``) will always be
+zero and not updated.  Hence the mode is called Data Attributes "only"
+monitoring.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3
