Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8C46B7
	for <damon@lists.linux.dev>; Mon, 27 Jun 2022 18:57:14 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id cu16so16156717qvb.7
        for <damon@lists.linux.dev>; Mon, 27 Jun 2022 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOsgPwcDx+OihP7CM9EgDPr6TtruXCYq9aRNj46ysBQ=;
        b=m2eUHMAtpzvN+Y99ePVbPBQhAiBwfdEMa4sYWEHf2vtSBRaVt/SObAY73NbhrfVRfT
         bIAQti3EBUREmLes+VGyWRM/whbdbjPFFIuDU/j3NkDwPE/jOD3NueZzE82yw60Vs2Yc
         3a8s7Yt92kyWFupcn49IGDFq2DfzziTMaUL/KsaDcRlQ+mv5JEU1/Z8gxzeJP5Mq7INE
         mZyZpzrs+NVF5UJ38AiWA7JgBQu6LWX5NqeYEMPyHcLd7m4ZvXM1mtntv9xK71DmrCJV
         3PLqp6sEguoeleMa70eC8OzsTFBtGVG58Kmve2RhNwey7dXpIv6CFExpLh+oqa94Vqkr
         UQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOsgPwcDx+OihP7CM9EgDPr6TtruXCYq9aRNj46ysBQ=;
        b=oTlWOhj0oS6hupgmWwShhJrW+3zP9WQBd1gSWNSRV0G9ZSjTMy967QF7pnf5+7Abkx
         sVwLtFiXcEC3Z3V8duGhg/enmJlXaS8I8me1AIAjRA69QAjwAl6IL2aNGroX7vTCDuOi
         leGIkq/z3kmeEJMZ65czFT8ijFf9veiGjf1FZp/T1BEWBrsmgkMr8soX60VzQ8tx82tI
         1CTfZKaDHFGFhuiML9WRgtFz/B018dzONNPFbd/Gx1tTSmhkjHeyIYmlkUXFKzAiC4Yn
         ax8NcDRcS8sMhhi/tAf1qS9kvMothTNFAahyn5o4naPgUmBaDYGLCVFO4nSC4oEAQh9Y
         dEZg==
X-Gm-Message-State: AJIora/HEUt0cyQecxK0uj76pfSveF+Q8ybTnN0IVZJ7o/6XNK6YrGul
	AQTk39nWCXdjD4MVeALpkHw=
X-Google-Smtp-Source: AGRyM1v5DGJwQQuAEAEZGEeHt/yRbP+et2CeJtdJxfhZdyXi1ntL/oaNsKV7SbYf8pRvXiM6V6UuHQ==
X-Received: by 2002:a0c:9a0e:0:b0:470:5ffa:ff43 with SMTP id p14-20020a0c9a0e000000b004705ffaff43mr745456qvd.6.1656356233274;
        Mon, 27 Jun 2022 11:57:13 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g1-20020ac87f41000000b002f93554c009sm7781826qtk.59.2022.06.27.11.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:57:12 -0700 (PDT)
From: SeongJae Park <sj38.park@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Gautam <gautammenghani201@gmail.com>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kselftests/damon: add support for cases where debugfs cannot be read
Date: Mon, 27 Jun 2022 18:57:04 +0000
Message-Id: <20220627185704.58902-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7d6b7de6-4609-e6ca-0a88-1f9799c70769@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Hi Shuah,

On Mon, 27 Jun 2022 11:00:18 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:

[...]
> >> --- a/tools/testing/selftests/damon/_chk_dependency.sh
> >> +++ b/tools/testing/selftests/damon/_chk_dependency.sh
> >> @@ -26,3 +26,13 @@ do
> >>   		exit 1
> >>   	fi
> >>   done
> >> +
> >> +permission_error="Operation not permitted"
> >> +for f in attrs target_ids monitor_on
> >> +do
> >> +	status=$( cat "$DBGFS/$f" 2>&1 )
> >> +	if [ "${status#*$permission_error}" != "$status" ]; then
> >> +		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
> 
> btw - does this run as a regular user or does it need root privilege?
> If so add a test for that and skip with a message.

It needs the root permission, and does the check at the beginning[1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/damon/_chk_dependency.sh?h=v5.19-rc4#n9


Thanks,
SJ

> >> +		exit $ksft_skip
> >> +	fi
> >> +done
> >> -- 
> >> 2.36.1
> >
> thanks,
> -- Shuah
