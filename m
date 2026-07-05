Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264FE3AC0C8;
	Sun,  5 Jul 2026 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285081; cv=none; b=cY00fJpj62HBGQ8bpZIfqhTFHZnhkRhxtleu0XRDzeILPkq6Zgzl9NkxACcZ0RfqBRYWOxRxTYGF0Jqn/CIQyZQIUx0mzL9G8PFaeh+BdattgErowCLzYKpTLFNPJ7L4ulEqLao/oR5lp6gOQGirwqER7uL9JI2Ln9QEW1Cgvxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285081; c=relaxed/simple;
	bh=UH5C3y7KXBbar/+BkmBp3b7fl0+uxp/Y6QgHi2iCLJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWPrTFg7Au/LLq9c5zvGIqYxEwjWfZMQpm39s8B2SyKWV1RaCTCwtqiLLwzY+bUAeox4mmmxL5+Qoyc6v+r9dDrHO3vkUcqDy0Lw5rjWlwmB07MMbZs7yZFPL2FPdkycuABARazJH2ZtTubGgJmWJDOphd2o5nIJQekAs7mHkUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQIpDVAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQIpDVAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBBE1F00A3F;
	Sun,  5 Jul 2026 20:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285080;
	bh=b+H7iz0ORQgX6Mh2N/AhYCgCoxwIP8JacfdhyDalugg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQIpDVAZOr5y39SRg78850Pm0m+6gQDt7UrodKsXDLyGFJKKuEP52hykCktmgxEFc
	 LR3BsPDOs/i9Gh76p/1Ycaw3HERNHMdUYdhBqB/e6d3jf5++eeilcCvJFT1vGHo3ZS
	 IcIAIICN4TNNRz5EHswhbYIEG8hDM8Wn/TG82tt+/bqqRhaKc6shiRy5Kry5N3P2uz
	 bg5iIheASwQ/TIftep1MmcRIcyedcbtVSWEjUXYxeARCBJ8WEuE3VyV3+UHq+kgtOp
	 tfwAzRf6HT0rvNzFUbfqK7OlcLqtmo2MqD8c9JBrkW7UBwIZQp3CNeKz5gtjmUKocy
	 COnJpjpBDd/bQ==
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
Subject: [RFC PATCH 14/16] Docs/mm/damon/design: document attrs-only monitoring
Date: Sun,  5 Jul 2026 13:57:36 -0700
Message-ID: <20260705205743.98656-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705205743.98656-1-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
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
index 457d6e8bc7878..67398e2133036 100644
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
+what combination of the attributes the primary information is deeecided, by
+setting the priority weight value.  If the total sum of the weights is not
+zero, the mode is enabled.  The regions adjustment mechaanism uses the weighted
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
