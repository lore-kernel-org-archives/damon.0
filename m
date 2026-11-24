Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534625;
	b=MUApCG726oDDE1HTDHwsyvFC0dfQIl1LP+NrvdxH8gJaTWDl9lkP231TAINMkWsxDf3V
	 q0KFaCF4x1w1LKd5pJnNneOZCs04M4LsWsxhPbfU1hirW1R8IF69Z0jVKI1/xYlpqr8Ll
	 hjXZBIL3JGmIjQtY3I2SE1JfxfLqu//19unSuzDOXWKy1NkhAsKAwqfwuCD0VW/uQn2VZ
	 LZIGG9mrbR0SmgKJSuG32K67om1J3kbNAgNp7jLWpFNFWgpaPReuL584N2l5jIks388zZ
	 6CZIdunMWzExlls8YLk+8OHNVL3EAGM+Ykp3vxnskY5MQA7K4ZzbcosIaLCurqBjuBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534625;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IqhmwcTw4aKoGyh7zdAQ6ulpj9BNviPX5fZGZSAf2zE=;
	b=ABNDn/0ndGh9BeIH6Kbi97MrISVJ6n91f6GwX/0veKhT0b/MLFpKYR4fP0zqpSSXLhV/
	 PP23vCMAalb8wP4RM3zwARP01B9ZaNGzLz6Pu6YxsRiX3wQo2HJoXx1SQWEm+Y3uh0SQY
	 fvC48450M6FV+Kv0sL2ZrVU2V9pudpQjo7iVLfd8pkOMdq6CAecoPG/OSqIgGqpW1JRyp
	 84GHLrAkW2g0BiPiMAdapDZwqXpcFM1GwbxddIQ0OIofuQMbTqZ/2IwkFoIcJj8IZAkLK
	 psxoaJc9hLQRGgaPZwKoLMYyR/2RiA4dEHiH5JiM95/xSscEEMqio2e9EvZR60s8XsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/AqMsOR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F86606A32E;
	Tue, 24 Nov 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/AqMsOR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060A21F000EC;
	Tue, 24 Nov 2026 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534625;
	bh=IqhmwcTw4aKoGyh7zdAQ6ulpj9BNviPX5fZGZSAf2zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y/AqMsOR0wwJEglYyETt60ihIKF55pZiazQRwe1Q6GYQ5v6VTdoQmcqnGtjDmYLp3
	 4hrcCHzxgDQpIIvwi2zhDzrSqRELYikJDj0DP63JGlx07pIsEDCZ/LMxdmtRiL5xPm
	 QGRtQlbi4VFZNbn4VNC+0KyBy3AKkXD+Fh8Vm/BlKJV/2421Kaf+uJseaYehSxWukY
	 u0qmJxL1/gDwjKVpK8LkwgK8HoSApwlA8UC7ibvCEmbzM8bLPou9jaiCBPuM7u3+Vo
	 AQHM1ydFPhgQlbelKopjw+na9CDZTGb1voPkSReGZz0hD2TSAcDxB9fsMvqzY8vqpI
	 2+FNzCx+lB0gQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH v2 26/27] Docs/admin-guide/mm/damon/usage: update for user_report report support
Date: Tue, 24 Nov 2026 07:36:32 -0800
Message-ID: <20261124153636.91854-27-sj@kernel.org>
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

Update DAMON usage document for the newly added user_report type data
attribute report support.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index dd752b81efe34..9312db5973aeb 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -120,7 +120,7 @@ comma (",").
     │ │ ...
     │ reports/
     │ │ producers/nr_producers
-    │ │ │ 0/report_type,producer_state
+    │ │ │ 0/report_type,producer_state,addr_start,addr_end
     │ │ │ ...
 
 .. _sysfs_root:
@@ -770,6 +770,15 @@ Users can write below keywords for the producer to the file.
 
 - ``on``: Enable the producer.
 - ``off``: Disable the producer.
+- ``submit``: Generate and submit a new ``user_report`` type report, if
+  ``report_type`` is ``user_report``, and the producer is enabled.
+
+``addr_start`` and ``addr_end`` files are used only for ``user_report`` report
+type.  Those set the address range of memory to manually report .  Users can
+set the start and end address of the address range by writing the addresses to
+the files.  Note that it is open-end range (``[addr_start,addr_end)``) and
+therefore the end address is exclusive.  Reading the files shows the last
+successfully written input.
 
 .. _tracepoint:
 
-- 
2.47.3
