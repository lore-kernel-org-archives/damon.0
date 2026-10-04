Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D715377A81;
	Sun,  4 Oct 2026 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791100878; cv=none; b=cfMdt2nPfZq6p+c77kcPBuxIbKPSRs3FLxJecftwRC64CgJ/U8QuQUtO5BT9CXUJwqMk/m36/jiphgvSyhL8hpxw5FpTilPxzaXJZJLO4jCNt2XiZ0ZFoNZk5oKAp9Fsx7LeXnS7KaBv13Ul/kjQ//QP/Hgrxv0l+4Mvos3ppjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791100878; c=relaxed/simple;
	bh=iTOH66FzZXboDlHhAvgDRCZs+Jh0LxFBQvkk2OT22XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHoQHagvM5u6EdxxcA8bV+mJZROAFrnrzZ6IolvoWJpe0fj1kjBjihgaDJcK+ZabB/qvYBthqY3lOt5nFw/mReFWIkygyRTqIwxUHkdRTOXwGysU3WEpn9/Xpcrmb++Fv2wYW4NLkKekyVYXI+o891AOkUjJvGFbl2CNopWWHxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV2Oz3wP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV2Oz3wP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D391F000FF;
	Sun,  4 Oct 2026 08:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791100877;
	bh=p0bhkDeR0q/RIGHHdpd7D589iSN3oIrJp74cDlV3Lkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bV2Oz3wPh9CI2vgAGfVd43hYzt6c1uvlk7ix0Dq2MmknOdhfzHxfi/W7w31THvoWE
	 ebDtjhVfvO+acPp+9yL7RsNOL5Rnl8eTDIO+Fe1PPIQN6rHL5hOhIDu6621+gzqlv8
	 H83jxW1Eh7YMuhBvyHR7p5n+lW2MQhJ5AQ04Ynrvyg6TVqawhuYYm2op2HCUbhR+H2
	 ADXlY4fPPr0KuKg2w4ISnUM2WB9WJk9Mi3a4P8GEh0YgdiHnq8lPBivxcQSSUJYM1z
	 iVyyKP1HFEX+iRR952RqoePaLSF7/UVXRTOuVV/FT7PJh4eTrM7eD2LUyNM9bh8SmF
	 xfMmHCv1XGaSg==
From: SJ Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>
Subject: Re: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
Date: Sun,  4 Oct 2026 01:01:10 -0700
Message-ID: <20261004080110.37328-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261003202727.3673-1-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ravi,

On Sat,  3 Oct 2026 13:27:27 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> Add a tracepoint for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP quota goal
> evaluation.  The tracepoint fires once per quota-score computation when
> the goal metric is DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP, exposing
> context_idx, scheme_idx, nid, target_value, and current_value.
> current_value is reported as the quota tuning sees it, after the goal's
> complement setting is applied.
> 
> The DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric expresses node memory
> occupancy as basis points of eligible bytes.  This information is not
> exposed through any existing external interface (perf stat, /proc, or
> sysfs), so the tracepoint is the only way for userspace to observe the
> target and current eligible-memory basis point values at quota-scoring
> time.

Thank you for this patch!

We have damos_esz tracepoint.  Have you considered using it?  It doesn't expose
the current value, though.  I thought it wouldn't be real problem in most
cases, but I can show it could be problematic for node_eligible_mem_bp case, as
the metric value is not straightforward to see without using DAMON.

If you really need to know the current_value, I'm open to add a new tracepoint.
But I think it has no reason to make it only eligible_mem_bp specific.  How
about adding more general purpose tracepoint, and/or update the current_value
file [1] under the goal sysfs directory to show the current current_value for
all goal types?

[1] https://origin.kernel.org/doc/html/latest/admin-guide/mm/damon/usage.html#sysfs-schemes-quota-goals


Thanks,
SJ

[...]
