Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F627144B;
	Fri, 10 Jul 2026 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643046; cv=none; b=JZk2R8d4ENbhYzrJATd1zv9x+nsWgEBjS4D+HRdl5lhnixBeFrmw4q00In/Zh1MbMkXnI20Sy0jPjZE0m3uaNZmW1/I0iVJ1fevQr7jNP62icndQ1zK+y3q1rJT4G/yDxjxtl4fSmkWImZbq6vG25bpZ+2hvnqfogDdj73J+Vj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643046; c=relaxed/simple;
	bh=kSvPkTqUMQuNngP9MOjUUXHc6wov0cmX2dXhh/hqB5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZo3jMTAN3sP6ZCfU8vKI/ylURVzvMgARDfsbP4NkX+NB5VR1w9QJHCsm+dzFyhd+mKB3y+Oa+y18I1NdrjTd2+JTnFU5dBlyUNuOEW6lRsm36LoI6K5Sz9zpz/jEANsAlPvIqTkMPZerFX68oaGufYiybKaFVc8tCWk1pr1ltE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHRWloZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHRWloZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2511F00A3D;
	Fri, 10 Jul 2026 00:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643044;
	bh=8LCoQX0bHg1OYdjWEvzo4RN1ftxPbEZ5h4yD4yU742Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHRWloZ4uM94rK1QZVS2GzqB/SDuJOJaBqIX1pk+SGQ2TcO1+jVAT/OoBvjYqZXQ6
	 kbNuzs+Bop1g5M0Ax1bnWvWqdB6odFC7OcuqO37ZFhVfzdGm8Zxlm9qkGJTWY1A+40
	 TGdN8U20JMaZvPf4HpN8mqhBUdh8w/nurNCZIcSPKFtIT0ANXdMAVvWiwlj/ruby7+
	 SHEFp+LebUAbwqVK3uigNqvnMUBcY+B2L/MfNt7/ZhI2zHJlJaDOi6RfAfgHldR92s
	 eCG89ZzSaLMmf9ou9nDAD+Cooh7Q5NpvzQ9Tagux8qSNUV1IHIkAH2Knw9bw0HuHVn
	 OqMuhhYM+1Wdw==
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
Subject: [RFC PATCH v1.3 17/19] Docs/mm/damon/design: document attrs-only monitoring
Date: Thu,  9 Jul 2026 17:23:43 -0700
Message-ID: <20260710002349.111414-18-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710002349.111414-1-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
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
