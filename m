Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881468;
	b=YsohvTw6/j8e6ejvNv9GN69ebV8egqjLl41adBvwEvjMZPXDQ/W0NqlixQuGFRMWT16U
	 fWC9K2wI5S8bnHBTL78UzqeI8ke304yX5RZDcSmjmaW7fVfaqRlAdV2GGPm4AOipywa35
	 I61gzCT1ErTFcPMIuSWKzzW1CuUC/e4lnypUz26lab/HtHa617jdUET3njKU15jCBIPP7
	 /JSicST4ob8pHzZBVkBbbDcj7kclAY1OufpmnSBUP13uFWTACz3ZrWA7/T40htHQhC9Po
	 g3Dk2I59lV7zhwa4ajeFkANsBBBEEk290NzQiR3nLx4R5OlYCVQUd60j3ucJkvAty3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881468;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OIU3JLNWHpOdjhC1oWugb/pA68zhrZ3nKPJMqP131yI=;
	b=FzirN+nRzXMy/x5x/6wpdR2YopzaYrsFmQ4F8XHCO7qP9S+ZSTIEYA34wBk4L9La/d76
	 9T9EMyN1Sshtq2i0Mt3ylwuqg4O7taUQCV7EjY5NW1Z2mkHcQb1Xuab1NlThHjeawWDS+
	 /g5GO+aYZBeFiCCcGp/Z/8EYDm9FPvjWlWkDaoyOQJDm/FJ0/yHBvz3jwjnCqubUMCiEy
	 oxthhFmPL4GUpwzS5EgE198HR6K2yxp99WNO+HAl1zH2OQpE0Wj8ol/jpHLPsjgTw9h5C
	 JAhZFbxAqSi/lzit69MvUeRguQp+TJTCoRuFgx0qxzwohAcNlP5HqYqHQiq2lciyUtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaCv0r6x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA0606A31C;
	Tue, 17 Nov 2026 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaCv0r6x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCD01F000C4;
	Tue, 17 Nov 2026 02:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794881468;
	bh=OIU3JLNWHpOdjhC1oWugb/pA68zhrZ3nKPJMqP131yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aaCv0r6x0VGJLSAZ8LFq+GzvYSLaiP72qGaZOkYrzPNMoULqActDR/Aa7+Tj3GBUs
	 RNdlgyuNRW29fJnli8IXGFb6reLbapmp9cwiRSXrsPdJSXbuLMmEowGS2gjtQr4xlX
	 yqaJdxmBT63IKgHHhI2UY4yfk5EAipfdiKAi1P9ZFrdREXdUitqiDOifb2jOJKYvA5
	 kbAkJtug1feq9gVaoFxEILGPE0ScTUXmBvU+hM/Mbq+flHarDD8rorfXrsKDOdcMpr
	 7dghR6L1ao7Rum25NfXLIr9FTLRdGFuZqqTHAm8gDvNUtxwVliePyBZZpslvvW//Jh
	 IE+COOfIQ0WRQ==
From: SJ Park <sj@kernel.org>
To: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mattathias Pinchover <mattathias.pinchover@uber.com>
Subject: Re: [PATCH 2/6] mm/damon/sysfs-schemes: add sz_ops_filter_passed_last file
Date: Mon, 16 Nov 2026 18:10:54 -0800
Message-ID: <20261117021055.110011-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116-damon-sz-ops-b4-v1-2-1cffe7227e6d@uber.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 16 Nov 2026 19:10:05 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
> 
> Introduce a new DAMON sysfs interface file for exposing the newly added
> DAMOS stat, sz_ops_filter_passed_last.  The file has the same
> name as the stat and is placed under the DAMOS stats directory.  Like
> other stats files, it is updated when the stats are refreshed via
> refresh_ms or the update_schemes_stats command.

Looks good to me.

> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
> ---
>  mm/damon/sysfs-schemes.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
[...]
> @@ -485,6 +495,10 @@ static struct kobj_attribute damon_sysfs_stats_sz_applied_attr =
>  static struct kobj_attribute damon_sysfs_stats_sz_ops_filter_passed_attr =
>  		__ATTR_RO_MODE(sz_ops_filter_passed, 0400);
>  
> +static struct kobj_attribute
> +damon_sysfs_stats_sz_ops_filter_passed_last_attr =

Seems the above two lines could be in a single line without breaking the 80
characters per line limit.  Could we just do so and save one line?

Other than that,

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
