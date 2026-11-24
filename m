Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534618;
	b=3ITdhZWlgTxJdIkztJVUoIhTp+e4l7aRXYBFBZubeQLbCwVhQydW/tJIrJ0dGl+AfpQ6
	 KNanLTPQNophUjJZcYXeCXWuf26L1SkGj+H4fnYV8U4cKcY5V3UG3BY8yPq3dSnLKrJOa
	 mE5DxPJxHmqtwAsITslA2wZ38q7mfo93/mPg83sRxKJz8RN/6VFzfXKpVltMG6hJfzTdr
	 wQ6pZ3FRWRJbCVYIQzztDUUFayLI06lCKuuyT6qZ6BU34/jy6RiZcRI498hwVAfgr3he4
	 n7D56LLQ3ZDj9NYcqBImRZYgWLTB+8ZUPzPhH0zFGnU+BspC/glLPvZUT9hvIGs07GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534618;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xEjKo21GUSpaZYoS3oGl37XQDP4bLf817sv8GkFZ5dQ=;
	b=z9ViVn8tj9JkUfU8KnAiLtdOet5nmxpQWEUqGRxkWv8kRJ2D2vj/xMeOr8ttte8fYOZn
	 K5zryue9Af3E06isx6ZAmVLiVjNzOg9xgW7ewUzIRffa6AObToG0rsKxBuThTi3fnw6lK
	 dm+vbryb31k8QlxoGxSZe8NijdNPebW5czeZealqOU3XnE7BvGqXVbMFXsrUzhYB6SYSW
	 jeQz7uCAOHYF6DV92HYnSby6tebuiywHjHDA7C43NqCgg2tnNM4iTyK46j1INWyN6UD8u
	 HfNClXwxNBdl4HWeliE4xnaRo/YNafw3IPvvyxFkF/sQJdbl6K+pZZ2IoTdhdL3QNzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5h9YQnW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CA1606A31E;
	Tue, 24 Nov 2026 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5h9YQnW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1349D1F000E0;
	Tue, 24 Nov 2026 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534618;
	bh=xEjKo21GUSpaZYoS3oGl37XQDP4bLf817sv8GkFZ5dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E5h9YQnWYZawNwmytHCWraUthL9wG1CDuDKo6DvRayPOKNWDuAgt1n7saiDcg4pxY
	 GS5XVTqQX2JKm8YQcapkS8J8kykslHb0Q7gk7FzCS2Lh/9AiP8TIUaqnOKlsO/ctzW
	 0TRdcQJ8TE4UXi4RUXxkmCS8HNt2tuZBb3deyxGtYjpIUDZ964c/aSVWoJgRe4fYM7
	 ROqEKsZDl7x31xsAc2w5VCk3lwbW7aI6ymN1A3CWv/+TtA+Ns4OQHwDPE3teJl+Y01
	 LERZIVfNYztdL7NAuT4cOcZVRA226NbFKWOLRTM8+vsxHGDEmt0uLMNHuiJ0iqzJAN
	 FNIRboT2uTmSw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 18/27] Docs/admin-guide/mm/damon/usage: update for REPORT_MADE probe filter
Date: Tue, 24 Nov 2026 07:36:24 -0800
Message-ID: <20261124153636.91854-19-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added REPORT_MADE type probe
filter support.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 5e0633b5879de..dd752b81efe34 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -78,7 +78,7 @@ comma (",").
     │ │ │ │ │ │ │ │ │ 0/prep_action
     │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ │ filters/nr_filters
-    │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path,min,max
+    │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path,min,max,filter_report_type
     │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ ...
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
@@ -320,6 +320,10 @@ filter <sysfs_filters>`.  When the filter ``type`` is ``hugepage_size``,
 ``min`` and ``max`` files act as files of the same names for :ref:`DAMOS
 filter <sysfs_filters>`.
 
+When the filter ``type`` is ``report_made``, the :ref:`report
+<damon_design_attr_reporting>` type for the filtering should also be specified
+by writing the type name to ``filter_report_type`` file.
+
 .. _sysfs_targets:
 
 contexts/<N>/targets/
-- 
2.47.3
