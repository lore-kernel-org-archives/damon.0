Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0D41A794
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529090; cv=none; b=bPMo9g77NJ31N7NmNTKMnB6LNT+5uzBu49Pa6gdSPZbxVFmfeEtdKnc7LEqeCHXntgOSsqOFFat/re/p/CavK88e9u0bjp2riG4iHf/v0JxWcPFr632Y5KaIVBPybMQv4XwAFovcH1/St6vFWYY8e/hV6LNwkkUAi+iD6jhi4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529090; c=relaxed/simple;
	bh=WoRaB0EVawwkliHkuJGoRlvGJWhSJmMEuytPdrNemKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/X15oztAnqpXcPKsHQgkgWD7j7HynQIN/QfWvCRTI974S54obI901/zwd6vuftExN4XOuJNUTm+HUdjG8J5p68mM9Az5Fia1m6eGa7LeZ3gfml0t0yPbIt2zmVmMVC5IILQni7rGFSLHKOtKpkTXpHhFBHVB4liYaVFDMyu624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuNLSfl7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuNLSfl7"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so981572a91.0
        for <damon@lists.linux.dev>; Wed, 12 Aug 2026 03:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786529088; x=1787133888; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IlE/rwBm4Ajsne+/ftC1sXbsOIllDwyjWRq3dt4Owgg=;
        b=NuNLSfl7Ngq2LPJHrKFf9MuyU2zL5zSCg+ZvXC4CmvVhFnKAGn8/4qA2zHkT+TzJd7
         NStWQEnjftabuIRptEwUggxObUi2R1/WBDVpet8R1WkKR6eqBmcEGf/DJeNFlKjlvVK/
         t0CEdD9DPn7UKV/bDfm1sBRUrWCHUzGIMXD3gltyQC9rKUW9wFMFDBpOrLd0jya9WoSi
         MiFY5asI01X4Mx/FO0xUn/wBQJNRwsqsvSPbLvp32Aq9uY0YZSBbJ5EI5GtHS+Hkyy82
         rZwQyF+lxkwa3tj98gl1orSft0oLRygSsp8VE83bHmd6i9m6oqy/2tOEWqi6vIQftwOA
         hesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786529088; x=1787133888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IlE/rwBm4Ajsne+/ftC1sXbsOIllDwyjWRq3dt4Owgg=;
        b=KR9Hb2RO7TqFwwTKQUBkZqlVnOKBwRmsJ8YZKxS/EloRNU6nXHQHWUXi+NDzyukMGn
         W8ASVsZ+opE5oppoeU6OSXenR4rAu8nowEa2db5TQK5XhdNq/DgUo/Xcx0+ZiairrIki
         SWb2MOwEoERJIPii5K+En5weYkdWbgYf/FHs8QSqAwiW2uzcT0hn5hFenyfOHyROIfPk
         oUmGFZUf0tfl+yrYTtdJaRlsFzdYeGlQHrILtg+ecIduLKn75QzBYJoXBw04e7ow8V/z
         ZYAL6/RWZDGElX4JGVRbxl2nby77S85mIws+M9mmEXy1BJd7/XY+VTns57zxqkWsSqMc
         /jlw==
X-Forwarded-Encrypted: i=1; AHgh+RoMI+g4gGLy4s6q1ZrOcI3wdVkeyk9d4F8lep3NQS+fkqbqriZ5UDH2EKEAVr2jGEBRrN54Fw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8bdVyxcQfXhzYHNINCoaHGZWbkgXMRmAIAWfUFhZvzO46E/kN
	IFEuESgELMqnRkjf/ZZZv4nWKddKjcgfUEZk5wfiQjli0tHvYxmtfARs
X-Gm-Gg: AR+sD13fQcvxHuX1vDsbo+KAVh5sS0zJMw9TOfYqzxVJqXecUgl4jY17ooejV6A6bWN
	QdB9vz/nV0zYtVh71pi6yStxqunL37ZCwvwjXsnv26KVFcUQfRSJykHiDYybhjWhJgGhcslTO6w
	cy0L15MEKsSJjYUeMnRmfFwj4VGoZaynKHzXvD/LhvG0aaSGsgzImKIxEfalIiL/nFz0ABlUc4o
	BUop/S0heUkZEFMsouHID/iWPkrBIPpSY+0JvBqsDsrNiyjQ+/UkDWrCO4wt7O7zaGS+QaTKNi+
	/9Hp7p2aNJGpbvCSeDSl7Of1aXfEoS9RIOTeLzmsV7sYj+dQm7gedd5svtOl9hGCY/dRMDu/uTo
	g5TizSutkxou57S39FTrSD81eAU+R9NU6HgZ9cQO2czYpeeE2XjJl8AxKFiEdl64kH/Jvn8kLqR
	oTzj/+1yPLUFmItwpH4Z+YGnXyt4bokVYHNwQIpOeGUYGtBKbNQ/vggNIdF3BUBqbgtAhwtXN4N
	bQbReBt+XWUqExHCpyEG7JYJg==
X-Received: by 2002:a17:90b:5443:b0:37f:f4ae:5f25 with SMTP id 98e67ed59e1d1-393014b4064mr4301528a91.20.1786529087671;
        Wed, 12 Aug 2026 03:04:47 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14124454d3csm8821247c88.2.2026.08.12.03.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:04:46 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH 1/3] docs/mm/damon/design: accurate semantics of nr_snapshots
Date: Wed, 12 Aug 2026 18:04:31 +0800
Message-ID: <20260812100433.6288-2-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812100433.6288-1-aethernet65535@gmail.com>
References: <20260812100433.6288-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change "tried to be applied" -> "tried to be completely applied" to
maintain consistency between the documentation and the code.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 Documentation/mm/damon/design.rst | 4 ++--
 include/linux/damon.h             | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aed6cb1cf483..1739aeec6eb9 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -846,8 +846,8 @@ scheme's execution.
 - ``nr_applied``: Total number of regions that the scheme is applied.
 - ``sz_applied``: Total size of regions that the scheme is applied.
 - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
-- ``nr_snapshots``: Total number of DAMON snapshots that the scheme is tried to
-  be applied.
+- ``nr_snapshots``: Total number of DAMON snapshots that the scheme is
+  completely tried to be applied.
 - ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
 
 "A scheme is tried to be applied to a region" means DAMOS core logic determined
diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0c8b7ddef9ab..33914594fb48 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -357,7 +357,8 @@ struct damos_watermarks {
  *		Total bytes that passed ops layer-handled DAMOS filters.
  * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
  * @nr_snapshots:
- *		Total number of DAMON snapshots that the scheme has tried.
+ *		Total number of DAMON snapshots that the scheme is completely
+ *		tried to be completely applied.
  *
  * "Tried an action to a region" in this context means the DAMOS core logic
  * determined the region as eligible to apply the action.  The access pattern
-- 
2.55.0

