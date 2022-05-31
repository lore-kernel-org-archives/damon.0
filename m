Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52A20E0
	for <damon@lists.linux.dev>; Tue, 31 May 2022 02:29:47 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id s68so11529191pgs.10
        for <damon@lists.linux.dev>; Mon, 30 May 2022 19:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yTMqOEWwFqPjCBnVwjlOgGC66EofdLuSUHGdwSY9I+8=;
        b=ifK6uC52NIu+skSIrfHV4J0Njr/BqESkbdnpQzfXZBHNX484VlgcJ10oKykmGIxafE
         0EDDPPYN4F8OVULDZIuwqS3yV0AF7gZ7Vpp9BgC/aWqaFBkVC/9BXmLFLceF7f2ufQx6
         lSRznUnCv6gFoEqk6Dp8bGhBwn1/vD+QxF7bnz9kpitHp5WhwB3EHf7a/y0lrEeST0sZ
         /zufRzC13BMCmsNSXP5+HnTefpCOWnzEXM/7Y0pyHUrDvUlnTGTIFlb7QPhEf9NBIJEu
         d27c64bECTIj2R8mvRiNHgZqktfyZkNueqCLPBTnZiei9NBEepPd8Cu1UPLPb/Be11j2
         LAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yTMqOEWwFqPjCBnVwjlOgGC66EofdLuSUHGdwSY9I+8=;
        b=z61Nxi6AAgHTISrEg8CQjBt3jnDYFLkjSbVX+6JmV6xQH8iZeRHpZiyTYDm+y3tYIO
         XYPrAV5YWZJnH17XsfTk1St2S/heYNN71IuPBJb2MTJsUe++KFKkwOc0lijGeYYgTzv7
         jZHrh5sFff65AGT/Rp4nBD0pkcYALTI8Ugs+JueNP6f2ja4cKxZ2Kbua1gnwQcilsKDd
         z/G5xwKDAdjLtYCIx4Q8ggWqPzcwrTk9GqJi1KWe+L0xJ39WkSOInYVscJVB8YqWcA4B
         UZDIHV1eOn9Xc5c1Qt74h1LTJrj8YMaSMbK6b1xsVxb/iYDoGUvhqZhPwGDFQH0UMWXN
         aYmQ==
X-Gm-Message-State: AOAM532B+aC5+1RG0F8Dqlazk9VZooc2At9i6+Xok7McGCR7U9/DH1CV
	BOf7SI2MtA4Y5rePpCwV3RyS+A==
X-Google-Smtp-Source: ABdhPJzahjwX8i93rNK2hQ9Yjfe9NmcWBos5aMcxAe2dGetSUWu3B4DPJ7deCw59XuI8/a5VaFZnRw==
X-Received: by 2002:a63:688a:0:b0:3fa:a80c:a228 with SMTP id d132-20020a63688a000000b003faa80ca228mr28184578pgc.182.1653964187033;
        Mon, 30 May 2022 19:29:47 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:7163:3a36:783f:6d4a])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902d10300b0016152774878sm3631059plw.176.2022.05.30.19.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 19:29:46 -0700 (PDT)
Date: Tue, 31 May 2022 10:29:41 +0800
From: Muchun Song <songmuchun@bytedance.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: sj@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: remove obsolete comments of kdamond_stop
Message-ID: <YpV9lQ3IAMmIJFCw@FVFYT0MHHV2J.googleapis.com>
References: <20220530022016.11771-1-zhouchengming@bytedance.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530022016.11771-1-zhouchengming@bytedance.com>

On Mon, May 30, 2022 at 10:20:16AM +0800, Chengming Zhou wrote:
> Since commit 0f91d13366a4 ("mm/damon: simplify stop mechanism")
> delete kdamond_stop and change to use kthread stop mechanism,
> these obsolete comments should be removed accordingly.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>
