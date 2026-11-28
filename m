Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795879263;
	b=1j89X0ffvtkdPNPzgnVMMbQ4rm1qF7Ct+bJNgJeoa+rB4d++qhrBpjuiO74EXxe6idtY
	 UvWFaYCxTBoF6n9D/i+hoXsaSUroYAWR8BktFi6QWuae0xgvKEoJqoUD2Ul+omYJdUhwg
	 qax67UB2lMlZhOEe2uPdQProAXhcsWN8oTsnbnlFg+Io3R+ZjLrjMsdbWLhxuCrivOFSq
	 KfuFQoxYQFgJ6G3xa5nPBUNThRpT2Ikw/65Xn6D7SHMjiB+r2KcQxloz7TpmF8Fx2bGDA
	 wUEfR+W+TeFceKpAseLkU8tXbO4UNuiii5i2yEmrifAlh1TtHk7m8xRyIAPAkIxBETg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795879263;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qm04MBvz2Y63JCUoqFg7aZSmg+lzVrWrvvpGSe6VlaM=;
	b=HVhNbaLHkPjAAsbnNgiJ74XuSTZHrhUIHmWpst95QVlUDR2pYG4Fwx1dax5DsKBf/QG1
	 C7mxMhxma0kECPnJ5mIOFskSY2lo73zaoaGOVcumRmuTwh4tUltoQq/WV2FtummdaM15R
	 Hzth5rJIUUcwgOna2YdDwx5x1dPGmEkzOyj37QAfrVTW/o6z35irOguy3t0AdIlG67e/R
	 JIp6XzMbE1MgnyZY6lXv1NQesgTDJSFX970R2q3hTcElUAVK4JEsbx728o2yQE396EwNW
	 tPlZmIniLTZM/cDz2ulgCNZF7eMxEDj93MFppbLzX8wUke6Hxmu4b5BjIPfOtiZ3u6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZyA5JrfN;
	arc=none smtp.remote-ip=91.218.175.217
Received: from mta0.migadu.com (out-217.mta0.migadu.com [91.218.175.217])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D55606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 15:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7D55606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZyA5JrfN
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=m19Ljk9g6FgMkrcIQ7jKszAwt0BWjklpw89BgxqR/6w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795879259; v=1; x=1796484059;
 b=ZyA5JrfN6I3HfP4lZN9IMc9lmG5+jXFdsitOlQufLnTGEnIiRLDZCvdsXBPY+ugEZ+aA1RlW
 Ghx8xeOLlUsUPLa0O5N3kUvQqfVc4PvQNH1VkL8Z7VkGzPxw0eo5gOrWHOSeyjvs9TONzykv0v4
 i73ZC7ggywyJsBApfgAbye3c=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 87a3939ef98a29ef;
	Sat, 28 Nov 2026 15:20:59 +0000
X-Mizu-Trace-ID: 87a3939ef98a29ef
X-Migadu-Flow: FLOW_OUT
Message-ID: <821ded57-8755-43d0-b35d-88296a6a56d2@linux.dev>
Date: Sat, 28 Nov 2026 23:20:52 +0800
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/27] mm/damon/api: introduce user_report report type
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-21-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-21-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi SJ,

Small question on this one, mostly out of curiosity.

On 2026/11/24 23:36, SJ Park wrote:
> Users could know some data attribute information and willing to provide
> that to DAMON.  Introduce a new damon_report_type,
> DAMON_REPORT_TYPE_USER_REPORT, for such user-provided reports.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 38efa41b3d1ab..45c82f536da59 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -759,9 +759,11 @@ struct damon_intervals_goal {
>  
>  /**
>   * enum damon_report_type - Type of &struct damon_report.
> + *
> + * @DAMON_REPORT_TYPE_USER_REPORT:	User-generated report.
>   */
>  enum damon_report_type {
> -	NR_DAMON_REPORT_TYPES,
> +	DAMON_REPORT_TYPE_USER_REPORT,
>  };

Here NR_DAMON_REPORT_TYPES is replaced by the real member instead of
being kept at the end as a counter.  A couple of other DAMON enums do
keep one, e.g. NR_DAMON_OPS and NR_DAMON_SYSFS_CMDS.

Then again, quite a few DAMON enums like damos_action and damos_filter_type
don't have it either, so I guess there is no strict rule.  Was there a
specific reason for dropping it here?  My guess is that nothing needs to
iterate over the report types yet, so it would just sit there unused.

And if more report types show up later, would you rather add the NR_
member back at that point?

Just asking to understand the plan, no strong opinion on my side.

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
