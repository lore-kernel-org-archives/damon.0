Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518AA10F1
	for <damon@lists.linux.dev>; Wed, 22 Jun 2022 03:09:22 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id l4so14865096pgh.13
        for <damon@lists.linux.dev>; Tue, 21 Jun 2022 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qeFLGzKyEitMeyLAF5p2SS4hTRAjoU69UDSP6vdWSjY=;
        b=p2wwgxhu9ut5UKfrtDC0rPYOS8CGYB4DZKXrTV8Z6vFZaGsCErBuey217nlClTv6sL
         F4xbgHt4MjpUrGsIfxCNeQqcdvLLcCo8zQRCZPoMa/FSPeUWBDmMVga+VitfhQKbIXKs
         RWirpynPoN/X+YpCHLmDmw67sKTa0bl3A0lzfyzEG2A/lyGOcWItAYsfTznkQRS6SQ/+
         /8m20H/hLi2E1/xgjLH9iLLvl+XnO3MrlCz8jZtna9qWwcAWVOrl04NY+SUT/ceAJF8j
         XhTyy6Yr4uf1yihCeZwvc3UQv1ubTwxn9/GHyyMgo+h+0pPS4enGayVOVjCuAKzF8Vkn
         MNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qeFLGzKyEitMeyLAF5p2SS4hTRAjoU69UDSP6vdWSjY=;
        b=53ZnKClOYZg/3n4BNQeoZ7vQ9uaiRX4paXeSGk1kCUp1SpuLSyDKY0JMJjrIGzyH+t
         R1Y8jiP9TNfC/PgL5oIKjvvKCP7jFYsCpfVR9bxJohJ4iohkl0tv5kDjES9QJwTCZD6M
         CkUgjLKmc9GDmS3WrEK63NBv29QMoxjQAIiP86v5e2DM5e/+j6sJicukWo3lIHaNDzqO
         C4QzAiblOpfhdFuaXiVSKRxGsmbGIQ6djMau5oENMjysQEMYBSM5Y512BvXZaCKM08nZ
         4uY6BFFD9JCys5SR6B0fX6ia92o2i+x7UfN3pIomOC6SXdpQOXPUHJ2T+YvG4pRy8qk9
         +gZw==
X-Gm-Message-State: AJIora/+0Pnneia9fUAZeBpUmEpufKVOeZsFhXpxrvTaPTwpAx4IUmXj
	2gW4at/a/M8CZF6QZLrf+sp3Ww==
X-Google-Smtp-Source: AGRyM1v/MjNT/bnm9g6Ofg4xP2CNsIToPVWuYeLOj+RxjCRuiNQqo1YZVEhQtNsoecrOZLGUHppubw==
X-Received: by 2002:a63:68c4:0:b0:3fb:984f:6779 with SMTP id d187-20020a6368c4000000b003fb984f6779mr1066855pgc.444.1655867361716;
        Tue, 21 Jun 2022 20:09:21 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id x16-20020a17090a165000b001e667f932cdsm13118167pje.53.2022.06.21.20.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 20:09:21 -0700 (PDT)
Date: Wed, 22 Jun 2022 11:09:16 +0800
From: Muchun Song <songmuchun@bytedance.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: sj@kernel.org, akpm@linux-foundation.org, mike.kravetz@oracle.com,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Use set_huge_pte_at() to make huge pte old
Message-ID: <YrKH3BlKA6sKdLbd@FVFYT0MHHV2J.usts.net>
References: <1655692482-28797-1-git-send-email-baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655692482-28797-1-git-send-email-baolin.wang@linux.alibaba.com>

On Mon, Jun 20, 2022 at 10:34:42AM +0800, Baolin Wang wrote:
> The huge_ptep_set_access_flags() can not make the huge pte old according
> to the discussion [1], that means we will always mornitor the young state
> of the hugetlb though we stopped accessing the hugetlb, as a result DAMON
> will get inaccurate accessing statistics.
> 
> So changing to use set_huge_pte_at() to make the huge pte old to fix this
> issue.
> 
> [1] https://lore.kernel.org/all/Yqy97gXI4Nqb7dYo@arm.com/
> 
> Fixes: 49f4203aae06 ("mm/damon: add access checking for hugetlb pages")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

The changes make sense to me.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

