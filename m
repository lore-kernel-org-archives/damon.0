Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8F38F658;
	Tue, 28 Jul 2026 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211981; cv=none; b=HJjZsay2azNYRlPCml105/5J4yhvIig6qjraC0+q3bbUeETwEJckRsF7nrYaX+8jZ8xvns5fQzXdOXCJjO1JCIfWwkLBUpiD5NGf2OVB6oZHetqGNEqpklPRSU3EflB+L2I5E7ZvVjyuq8zwuWTLJMj2DQMs74jb6KQWeC6ZTGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211981; c=relaxed/simple;
	bh=g/tFPfelQzKUfzsRZPs73xHoniRK3oTmoDYddCctcSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4/H9CIZlKGk+qUex0BUXjbyae9XA9h9JOKAU6Bikdwp/8VEzUCKAvnezkHcbGxUEk4ISzJA/0HrwnkQLbZaolGFqElbWTIWsXBEwo5gHFsj5p5YX/IagPG6r9Be35eQwYrDRWgYo3k4Pj6/87tCCcg2Rp58jAXKtlOCBkLa6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2dEu6gj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2dEu6gj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB181F01559;
	Tue, 28 Jul 2026 04:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211978;
	bh=PjqVhtQyye+bbFZP93YpIQ5LAq+rT1MA3lQj7bnBnXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C2dEu6gjew1sVQ013U5ot8/JjImPQeDjvFR0hp+Iopv5PLuzrtXdaOvhgaR2GN2Mx
	 C3w/uBFrEcR8RpvqhEbDpb5pUthMDyB51JLJLNRXo1QWLM57qdWcEWAQP0szxHHiwN
	 dKRJhmXOE4OhELaIT4jRHArdzIf/brcx2EEI7UY4KVFUWElGBYFiF5Qslk9yMBI0IB
	 GoWsbFcsAM7L1Je2u293J5h6EsNtr8Xxl9aSOGV1id2t/z57eQ85WIztzeajuKRzHy
	 x/WGD3/dQvIjTxLyBa2AgcVCuCMLxiCqdDf+NAignYJL+FPOFcZ2xvNwd3m8j4nIxY
	 9jKcuznFyodTA==
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
Subject: [RFC PATCH v2.2 16/17] Docs/admin-guide/mm/damon/usage: document probe preps sysfs files
Date: Mon, 27 Jul 2026 21:12:37 -0700
Message-ID: <20260728041242.187380-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728041242.187380-1-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added DAMON probe preps sysfs
files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index da5f9afd08aef..023c6334024f8 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -74,6 +74,9 @@ comma (",").
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ │ :ref:`probes <damon_usage_sysfs_probes>`/nr_probes
     │ │ │ │ │ │ │ 0/weight
+    │ │ │ │ │ │ │ │ preps/nr_preps
+    │ │ │ │ │ │ │ │ │ 0/prep_action
+    │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ │ filters/nr_filters
     │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path
     │ │ │ │ │ │ │ │ │ ...
@@ -283,9 +286,18 @@ In the beginning, this directory has only one file, ``nr_probes``.  Writing a
 number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each monitoring probe.
 
-In each probe directory, one directory, ``filters`` exists.  The directory
-contains files for installing filters for the probe, that is used to determine
-the data attribute for the probe.
+In each probe directory, two directories, ``preps`` and ``filters`` exist.  The
+directories contain files for installing probing preparation actions and
+filters for the probe, that are used to determine the data attribute for the
+probe.
+
+In the beginning, ``preps`` directory has only one file, ``nr_preps``.
+Writing a number (``N``) to the file creates the number of child directories
+named ``0`` to ``N-1``.  Each directory represents each preparation action.
+Each directory has one file, ``prep_action``.  The preparation action can be
+selected by writing the name of the action to the ``prep_action`` file.  Refer
+to the :ref:`design doc <damon_design_data_attrs_monitoring>` for the list of
+supported actions.
 
 Each probe directory also contains ``weight`` file.  Reading from and writing
 to the file gets and sets the :ref:`attributes-only monitoring
-- 
2.47.3
